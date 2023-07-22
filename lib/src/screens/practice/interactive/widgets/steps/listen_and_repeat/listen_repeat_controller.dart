import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/practice/interactive/controller/practice_stepper_controller.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

final listenRepeatControllerProvider = StateNotifierProvider.autoDispose<
    ListenRepeatController, ListenRepeatStates>(
  (ref) {
    return ListenRepeatController();
  },
);

class ListenRepeatController extends StateNotifier<ListenRepeatStates> {
  final tts = TextToSpeech();

  ListenRepeatController()
      : super(ListenRepeatStates(
            micState: false,
            stage: 1,
            micMessage: 'Now your turn : Hold to Start Recording ...'));

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  void stageMapper(
      MicWordState micWordState,
      MicSingleController micSingleController,
      PracticeStepperController practiceStepperController) async {
    final MicWordState(:countPron, :wordRecord, :examplePinter) = micWordState;
    final perfectDelay =
        (wordRecord.wordExamples[examplePinter].split(' ').length * 0.6).ceil();
    //* first case listen and activate mic
    if (countPron != 0 && state.stage == 1 && !state.micState) {
      _listen(micWordState, micSingleController);
      return;
    }
    //* move To Next Stage 2  and deactivate mic
    if (countPron == 0 && state.stage == 1 && state.micState) {
      if (mounted) {
        state = state.copyWith(
            stage: 2, micState: false, micMessage: micWordState.micMessage);
      }
      return;
    }
    //* move To Next Stage 3  and activate examples
    if (state.stage == 2 && !state.micState) {
      await _speakWithDelay(wordRecord.wordExamples[examplePinter], 0, rate: 1);
      await _speakWithDelay(
              wordRecord.wordExamples[examplePinter], perfectDelay,
              rate: 0.5)
          .then((value) {
        micSingleController.exampleActivation();
        if (mounted) {
          state = state.copyWith(
              stage: 3,
              micMessage: 'Now your turn : Try to Pronounce the sentence ');
        }
      });

      return;
    }
    if (countPron > 0 && state.stage == 3 && !state.micState) {
      await Future.delayed(Duration(seconds: perfectDelay));
      if (mounted) {
        state =
            state.copyWith(micState: true, micMessage: micWordState.micMessage);
      }
    }
    //* handle others
    if (countPron == 0 && state.stage == 3) {
      if (examplePinter < wordRecord.wordExamples.length - 1) {
        Future.delayed(Duration(seconds: perfectDelay));
        micSingleController.moveToNextExamples(examplePinter);
        if (mounted) {
          state = state.copyWith(
            micState: false,
            stage: 4,
          );
        }
      } else {
        practiceStepperController.updateNextStepAvailability(true);
        if (mounted) {
          state = state.copyWith(
              stage: 5, micMessage: micWordState.micMessage, micState: false);
        }
        return;
      }
    }
    if (state.stage == 4 && !state.micState) {
      await _speakWithDelay(wordRecord.wordExamples[examplePinter], 0, rate: 1);
      await _speakWithDelay(
              wordRecord.wordExamples[examplePinter], perfectDelay,
              rate: 0.5)
          .then((value) {
        if (mounted) {
          state = state.copyWith(
              stage: 3,
              micMessage: 'Now your turn : Try to Pronounce the sentence ');
        }
      });

      return;
    }
  }

  void reset(MicSingleController micSingleController,
      PracticeStepperController practiceStepperController) async {
    micSingleController.startOver();

    practiceStepperController.updateNextStepAvailability(false);
    state = state.copyWith(
      micState: false,
      stage: 1,
      micMessage: 'Now your turn : Hold to Start Recording ...',
    );
  }

  void playNormal(MicWordState micWordState) async {
    final WordRecord(:foreignWord, :wordExamples) = micWordState.wordRecord;
    if (state.stage == 5) {
      await _speakWithDelay(foreignWord, 0, rate: 1);
      for (var example in wordExamples) {
        await _speakWithDelay(example, 2, rate: 1);
      }
    } else {
      if (micWordState.activateExample) {
        await _speakWithDelay(
            micWordState.wordRecord.wordExamples[micWordState.examplePinter], 0,
            rate: 1);
      } else {
        await _speakWithDelay(foreignWord, 0, rate: 1);
      }
    }
  }

  void _listen(MicWordState micWordState,
      MicSingleController micSingleController) async {
    final WordRecord(:foreignWord) = micWordState.wordRecord;

    await _speakWithDelay(foreignWord, 0, rate: 1);
    await _speakWithDelay(foreignWord, 2, rate: 0.1);
    await _speakWithDelay(foreignWord, 2, rate: 0.3);
    await _speakWithDelay(foreignWord, 3, rate: 1);
    if (mounted) {
      state =
          state.copyWith(micState: true, micMessage: micWordState.micMessage);
    }
  }

  Future<void> _speakWithDelay(String text, int delay, {double rate = 1}) {
    return Future.delayed(Duration(seconds: delay), () async {
      if (mounted) {
        await tts.setRate(rate);
        await tts.speak(text);
      }
    });
  }
}

class ListenRepeatStates {
  final bool micState;
  final int stage;
  final String micMessage;

  ListenRepeatStates(
      {required this.micState, required this.stage, required this.micMessage});
  ListenRepeatStates copyWith({
    WordRecord? wordRecord,
    bool? micState,
    int? stage,
    String? micMessage,
  }) {
    return ListenRepeatStates(
      micMessage: micMessage ?? this.micMessage,
      stage: stage ?? this.stage,
      micState: micState ?? this.micState,
    );
  }
}
