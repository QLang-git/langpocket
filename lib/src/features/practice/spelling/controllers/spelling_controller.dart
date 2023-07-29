abstract class SpellingController<T extends SpellingStateBase> {
  void moveToNextWord();
  get isThereNextWord => null;

  void setWordRecords();
  void startOver();
  void exampleActivation();
  void comparingTexts(String text);
  void moveToNextExamples(int examplePinter);
  void setCorrectness(bool status);
}

abstract class SpellingStateBase {
  final int countSpelling;
  final bool activateExample;
  final int examplePinter;
  final bool correctness;

  SpellingStateBase({
    required this.correctness,
    required this.countSpelling,
    required this.activateExample,
    required this.examplePinter,
  });

  SpellingStateBase copyWith({
    int? countSpelling,
    bool? activateExample,
    int? examplePinter,
    bool? correctness,
  });
}
