import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/screens/practice/spelling/controllers/spelling_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

final spellingGroupControllerProvider = StateNotifierProvider.autoDispose
    .family<SpellingGroupController, AsyncValue<SpellingGroupState>, int>(
        (ref, groupId) {
  final currentWord =
      ref.read(wordsServicesProvider).fetchWordsByGroupId(groupId);

  return SpellingGroupController(currentWord);
});

const int _countWordSpelling = 5;
const int _countExampleSpelling = 3;
const bool _activateExampleState = false;
const int _examplePinter = 0;
const int _wordIndex = 0;

class SpellingGroupController
    extends StateNotifier<AsyncValue<SpellingGroupState>>
    implements SpellingController<SpellingGroupState> {
  final Future<List<WordData>> wordsFuture;
  SpellingGroupController(this.wordsFuture) : super(const AsyncValue.loading());

  @override
  void setWordRecords() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => wordsFuture.then((words) =>
        SpellingGroupState(
            wordIndex: _wordIndex,
            correctness: false,
            wordsRecord: words.map((e) => e.decoding()).toList(),
            countSpelling: _countWordSpelling,
            activateExample: _activateExampleState,
            examplePinter: _examplePinter)));
  }

  @override
  void startOver() {
    state = state.whenData((word) => word.copyWith(
        wordIndex: _wordIndex,
        countSpelling: _countWordSpelling,
        activateExample: _activateExampleState,
        examplePinter: _examplePinter));
  }

  @override
  void exampleActivation() {
    state = state.whenData((word) => word.copyWith(
        activateExample: true,
        examplePinter: _examplePinter,
        countSpelling: _countExampleSpelling));
  }

  @override
  void comparingTexts(String text) {
    final SpellingGroupState(
      :wordIndex,
      :activateExample,
      :countSpelling,
      :wordsRecord,
      :examplePinter
    ) = state.value!;
    if (activateExample && countSpelling > 0) {
      final res = _exampleSpellingChecker(text,
          wordsRecord[wordIndex].wordExamples, examplePinter, countSpelling);
      if (res) {
        state = state.whenData((word) => word.copyWith(correctness: res));
      }
    } else if (!activateExample && countSpelling > 0) {
      final res = _wordSpellingChecker(
          text, wordsRecord[wordIndex].foreignWord, countSpelling);
      if (res) {
        state = state.whenData((word) => word.copyWith(correctness: res));
      }
    }
  }

  bool _exampleSpellingChecker(String text, List<String> examplesList,
      int currentPointer, int countSpelling) {
    if (examplesList[currentPointer].toLowerCase().trim() ==
        text.toLowerCase().trim()) {
      TextToSpeech().speak(text);
      state = state
          .whenData((word) => word.copyWith(countSpelling: countSpelling - 1));
      return true;
    } else {
      return false;
    }
  }

  @override
  void moveToNextExamples(int examplePinter) {
    state = state.whenData((word) => word.copyWith(
        countSpelling: _countExampleSpelling,
        examplePinter: examplePinter + 1));
  }

  bool _wordSpellingChecker(
      String text, String foreignWord, int countSpelling) {
    if (foreignWord.toLowerCase().trim() == text.toLowerCase().trim()) {
      TextToSpeech().speak(text);
      state = state.whenData((word) => word.copyWith(
            countSpelling: countSpelling - 1,
          ));
      return true;
    } else {
      return false;
    }
  }

  @override
  void setCorrectness(bool status) {
    state = state.whenData((word) => word.copyWith(correctness: status));
  }

  @override
  void moveToNextWord() {
    final SpellingGroupState(
      :wordIndex,
      :wordsRecord,
    ) = state.value!;

    if (wordsRecord.isNotEmpty && wordsRecord.length > wordIndex) {
      state = state.whenData((word) => word.copyWith(
          wordIndex: word.wordIndex + 1,
          countSpelling: _countWordSpelling,
          activateExample: _activateExampleState,
          examplePinter: _examplePinter));
    }
  }

  @override
  get isThereNextWord =>
      state.value!.wordIndex < state.value!.wordsRecord.length - 1;
}

class SpellingGroupState implements SpellingStateBase {
  final List<WordRecord> wordsRecord;
  @override
  final int countSpelling;
  @override
  final bool activateExample;
  @override
  final int examplePinter;
  final int wordIndex;
  @override
  final bool correctness;

  SpellingGroupState({
    required this.wordIndex,
    required this.correctness,
    required this.wordsRecord,
    required this.countSpelling,
    required this.activateExample,
    required this.examplePinter,
  });

  @override
  SpellingGroupState copyWith(
      {List<WordRecord>? wordsRecord,
      int? countSpelling,
      bool? activateExample,
      int? examplePinter,
      bool? correctness,
      int? wordIndex}) {
    return SpellingGroupState(
        wordIndex: wordIndex ?? this.wordIndex,
        wordsRecord: wordsRecord ?? this.wordsRecord,
        countSpelling: countSpelling ?? this.countSpelling,
        activateExample: activateExample ?? this.activateExample,
        examplePinter: examplePinter ?? this.examplePinter,
        correctness: correctness ?? this.correctness);
  }
}
