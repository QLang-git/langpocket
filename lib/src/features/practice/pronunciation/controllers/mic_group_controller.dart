import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/features/practice/pronunciation/controllers/mic_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

const bool _activateExampleState = false;
const int _examplePinter = 0;
final micGroupControllerProvider = StateNotifierProvider.autoDispose<
    MicGroupController, AsyncValue<MicGroupState>>((ref) {
  final service = ref.watch(wordsServicesProvider);

  return MicGroupController(service);
});

class MicGroupController extends StateNotifier<AsyncValue<MicGroupState>>
    implements MicController {
  final WordServices service;
  MicGroupController(this.service) : super(const AsyncValue.loading());

  int _countPron = 3;
  int _countExampleMic = 2;
  final speechToText = SpeechToText();

  @override
  void setWordRecords({
    int? countPron,
    int? countExamplePron,
    String? exampleActivationMessage,
    required String initialMessage,
    required int id,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return service.fetchWordsByGroupId(id).then((words) {
        _countExampleMic = countExamplePron ?? _countExampleMic;
        _countPron = countPron ?? _countPron;
        return MicGroupState(
            indexWord: 0,
            isAnalyzing: false,
            wordsRecord: words.map((e) => e.decoding()).toList(),
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
    Future.delayed(const Duration(seconds: 5), () {
      if (speechToText.isListening && mounted) {
        speechToText.stop();
      }
    });
  }

  @override
  void stopRecording() async {
    if (speechToText.isListening) {
      await Future.delayed(
          const Duration(seconds: 2), () => speechToText.stop());
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

  @override
  void moveToNextWord() {
    final MicGroupState(
      :indexWord,
      :wordsRecord,
    ) = state.value!;

    if (wordsRecord.isNotEmpty && wordsRecord.length > indexWord) {
      state = state.whenData((word) => word.copyWith(
          indexWord: word.indexWord + 1,
          countPron: _countPron,
          activateExample: _activateExampleState,
          examplePinter: _examplePinter));
    }
  }

  @override
  get isThereNextWord =>
      state.value!.indexWord < state.value!.wordsRecord.length - 1;

  /// * `listening` when speech recognition begins after calling the [listen]
  /// method.
  /// * `notListening` when speech recognition is no longer listening to the
  /// microphone after a timeout, [cancel] or [stop] call.
  /// * `done` when all results have been delivered.
  bool noVoice = true;
  @override
  void statusListener(String status) {
    if (status == 'listening') {
      if (mounted) {
        noVoice = true;
        state = state.whenData((pron) =>
            pron.copyWith(micMessage: "listening...", isAnalyzing: false));
        return;
      }
    }
    if (status == 'notListening') {
      state = state.whenData((pron) => pron.copyWith(
          micMessage: "Analyzing your pronunciation...", isAnalyzing: true));
      return;
    }
    if (status == 'done' && noVoice) {
      state = state.whenData((pron) => pron.copyWith(isAnalyzing: false));
      return;
    }
  }

  @override
  void errorListener(String errorMsg) {
    if (errorMsg == 'error_no_match') {
      state = state.whenData((pron) => pron.copyWith(
          micMessage: "No voice detected. Please try again.",
          isAnalyzing: false));
    } else {
      state = AsyncError(errorMsg, StackTrace.current);
    }
  }

  void _resultListener(SpeechRecognitionResult result) {
    if (state.hasValue && result.finalResult) {
      if (state.value!.activateExample) {
        _comparingWords(
            result.recognizedWords,
            state.value!.wordsRecord[state.value!.indexWord]
                .wordExamples[state.value!.examplePinter]);
      } else {
        _comparingWords(result.recognizedWords,
            state.value!.wordsRecord[state.value!.indexWord].foreignWord);
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
        }
      }
    }
  }
}

class MicGroupState implements MicStateBase {
  final List<WordRecord> wordsRecord;
  final int indexWord;
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

  MicGroupState(
      {required this.countPron,
      required this.indexWord,
      required this.wordsRecord,
      required this.activateExample,
      required this.examplePinter,
      required this.isAnalyzing,
      required this.micMessage});

  @override
  MicGroupState copyWith(
      {List<WordRecord>? wordsRecord,
      int? indexWord,
      int? countPron,
      bool? activateExample,
      int? examplePinter,
      bool? isAnalyzing,
      String? micMessage}) {
    return MicGroupState(
        indexWord: indexWord ?? this.indexWord,
        wordsRecord: wordsRecord ?? this.wordsRecord,
        countPron: countPron ?? this.countPron,
        activateExample: activateExample ?? this.activateExample,
        examplePinter: examplePinter ?? this.examplePinter,
        isAnalyzing: isAnalyzing ?? this.isAnalyzing,
        micMessage: micMessage ?? this.micMessage);
  }
}
