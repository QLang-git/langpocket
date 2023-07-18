import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/mic_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

const bool _activateExampleState = false;
const int _examplePinter = 0;
final micSingleControllerProvider = StateNotifierProvider.autoDispose
    .family<MicSingleController, AsyncValue<MicWordState>, int>((ref, wordId) {
  print('wordId $wordId');
  final currentWord = ref.watch(wordsServicesProvider).fetchWordById(wordId);

  return MicSingleController(currentWord);
});

class MicSingleController extends StateNotifier<AsyncValue<MicWordState>>
    implements MicController {
  final Future<WordData> wordDataFuture;
  MicSingleController(this.wordDataFuture) : super(const AsyncValue.loading());

  @override
  void dispose() {
    // Stop speech recognition if it's currently active.
    stopRecording();

    super.dispose();
  }

  int _countPron = 3;
  int _countExampleMic = 2;
  final speechToText = SpeechToText();

  @override
  void setWordRecords(
      {int? countPron,
      int? countExamplePron,
      required String initialMessage}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      _initializeSpeechToText();
      return wordDataFuture.then((word) {
        _countExampleMic = countExamplePron ?? _countExampleMic;
        _countPron = countPron ?? _countPron;
        return MicWordState(
            isAnalyzing: false,
            wordRecord: word.decoding(),
            countPron: _countPron,
            activateExample: _activateExampleState,
            examplePinter: _examplePinter,
            micMessage: initialMessage);
      });
    });
  }

  @override
  void startRecording() async {
    if (speechToText.isNotListening) {
      await speechToText.listen(onResult: (speech) {
        if (mounted) {
          _resultListener(speech);
        }
      });
    }
  }

  @override
  void stopRecording() async {
    if (speechToText.isListening) {
      await speechToText.stop();
    }
  }

  @override
  void startOver() {
    state = state.whenData((word) => word.copyWith(
        isAnalyzing: false,
        countPron: _countPron,
        activateExample: _activateExampleState,
        examplePinter: _examplePinter));
  }

  @override
  void exampleActivation() {
    state = state.whenData((word) => word.copyWith(
        activateExample: true,
        examplePinter: _examplePinter,
        countPron: _countExampleMic));
  }

  @override
  void moveToNextExamples(int examplePinter) {
    state = state.whenData((word) => word.copyWith(
        countPron: _countExampleMic, examplePinter: examplePinter + 1));
  }

  void _initializeSpeechToText() async {
    final permission = await speechToText.initialize(
      onError: ((errorNotification) {
        if (mounted) {
          _errorListener(errorNotification);
        }
      }),
      onStatus: ((status) {
        if (mounted) {
          _statusListener(status);
        }
      }),
    );
    if (permission) {
      state = state.whenData((pron) => pron.copyWith(
          micMessage: "Permission denied. Please enable microphone access."));
    }
  }

  /// * `listening` when speech recognition begins after calling the [listen]
  /// method.
  /// * `notListening` when speech recognition is no longer listening to the
  /// microphone after a timeout, [cancel] or [stop] call.
  /// * `done` when all results have been delivered.

  void _statusListener(String status) {
    if (status == 'listening') {
      state =
          state.whenData((pron) => pron.copyWith(micMessage: "listening..."));

      return;
    }
    if (status == 'notListening') {
      state = state.whenData((pron) => pron.copyWith(
          micMessage: "Analyzing your pronunciation...", isAnalyzing: true));
      return;
    }
    if (status == 'done') {
      state = state.whenData((pron) => pron.copyWith(isAnalyzing: false));
      return;
    }
  }

  void _errorListener(SpeechRecognitionError errorNotification) {
    if (errorNotification.permanent) {
      state = state.whenData((pron) => pron.copyWith(
          micMessage:
              "Microphone is unavailable. Check permissions and try again later."));
    } else {
      state = state.whenData(
          (pron) => pron.copyWith(micMessage: errorNotification.errorMsg));
    }
  }

  void _resultListener(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    if (state.hasValue && result.finalResult) {
      if (state.value!.activateExample) {
        _comparingWords(result.recognizedWords,
            state.value!.wordRecord.wordExamples[state.value!.examplePinter]);
      } else {
        _comparingWords(
            result.recognizedWords, state.value!.wordRecord.foreignWord);
      }
    }
  }

  void _comparingWords(String recognizedText, String originText) {
    if (state.value!.countPron > 0) {
      if (recognizedText.toLowerCase().trim() ==
          originText.toLowerCase().trim()) {
        state = state.whenData((pron) => pron.copyWith(
              countPron: state.value!.countPron - 1,
              micMessage: "Great job! You got it right.",
            ));
      } else {
        if (recognizedText.isNotEmpty) {
          state = state.whenData((value) => value.copyWith(
              micMessage:
                  "Oops! \"$recognizedText\" doesn't match. Try again."));
        } else {
          state = state.whenData((pron) => pron.copyWith(
              micMessage: "No voice detected. Please try again."));
        }
      }
    }
  }

  @override
  void moveToNextWord() {
    throw UnimplementedError();
  }

  @override
  get isThereNextWord => throw UnimplementedError();
}

class MicWordState implements MicStateBase {
  final WordRecord wordRecord;
  @override
  final int countPron;
  @override
  final bool activateExample;
  @override
  final int examplePinter;
  @override
  final String micMessage;
  @override
  final bool isAnalyzing;

  MicWordState(
      {required this.countPron,
      required this.wordRecord,
      required this.activateExample,
      required this.examplePinter,
      required this.isAnalyzing,
      required this.micMessage});

  @override
  MicWordState copyWith(
      {WordRecord? wordRecord,
      int? countPron,
      bool? activateExample,
      int? examplePinter,
      bool? isAnalyzing,
      String? micMessage}) {
    return MicWordState(
        wordRecord: wordRecord ?? this.wordRecord,
        countPron: countPron ?? this.countPron,
        activateExample: activateExample ?? this.activateExample,
        examplePinter: examplePinter ?? this.examplePinter,
        isAnalyzing: isAnalyzing ?? this.isAnalyzing,
        micMessage: micMessage ?? this.micMessage);
  }
}
