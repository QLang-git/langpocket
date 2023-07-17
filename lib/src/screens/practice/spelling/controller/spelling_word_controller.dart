import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/screens/practice/spelling/controller/spelling_controller.dart';
import 'package:langpocket/src/screens/practice/spelling/controller/spelling_group_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

final spellingWordControllerProvider = StateNotifierProvider.autoDispose
    .family<SpellingWordController, AsyncValue<SpellingWordState>, int>(
        (ref, wordId) {
  final currentWord = ref.watch(wordsServicesProvider).fetchWordById(wordId);

  return SpellingWordController(currentWord);
});

const int _countWordSpelling = 5;
const int _countExampleSpelling = 3;
const bool _activateExampleState = false;
const int _examplePinter = 0;

class SpellingWordController
    extends StateNotifier<AsyncValue<SpellingWordState>>
    implements SpellingController<SpellingWordState> {
  final Future<WordData> wordDataFuture;
  SpellingWordController(this.wordDataFuture)
      : super(const AsyncValue.loading());

  @override
  void setWordRecords() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => wordDataFuture.then((word) =>
        SpellingWordState(
            correctness: false,
            wordRecord: word.decoding(),
            countSpelling: _countWordSpelling,
            activateExample: _activateExampleState,
            examplePinter: _examplePinter)));
  }

  @override
  void startOver() {
    state = state.whenData((word) => word.copyWith(
        correctness: false,
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
  void comparingTexts(String text, SpellingWordState spellingWordState) {
    final SpellingWordState(
      :activateExample,
      :countSpelling,
      :wordRecord,
      :examplePinter
    ) = spellingWordState;
    if (activateExample && countSpelling > 0) {
      final res = _exampleSpellingChecker(
          text, wordRecord.wordExamples, examplePinter, countSpelling);
      if (res) {
        state = state.whenData((word) => word.copyWith(correctness: res));
      }
    } else if (!activateExample && countSpelling > 0) {
      final res =
          _wordSpellingChecker(text, wordRecord.foreignWord, countSpelling);
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
  get isThereNextWord => throw UnimplementedError();

  @override
  void moveToNextWord() {
    throw UnimplementedError();
  }
}

class SpellingWordState implements SpellingStateBase {
  final WordRecord wordRecord;
  @override
  final int countSpelling;
  @override
  final bool activateExample;
  @override
  final int examplePinter;
  @override
  final bool correctness;

  SpellingWordState({
    required this.correctness,
    required this.wordRecord,
    required this.countSpelling,
    required this.activateExample,
    required this.examplePinter,
  });
  @override
  SpellingWordState copyWith(
      {WordRecord? wordRecord,
      int? countSpelling,
      bool? activateExample,
      int? examplePinter,
      bool? correctness}) {
    return SpellingWordState(
        wordRecord: wordRecord ?? this.wordRecord,
        countSpelling: countSpelling ?? this.countSpelling,
        activateExample: activateExample ?? this.activateExample,
        examplePinter: examplePinter ?? this.examplePinter,
        correctness: correctness ?? this.correctness);
  }
}
