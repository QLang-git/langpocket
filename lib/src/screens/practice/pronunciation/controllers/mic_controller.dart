abstract class MicController<T extends MicStateBase> {
  void moveToNextWord();
  void setWordRecords(
      {int? countPron, int? countExamplePron, required String initialMessage});
  void startOver();
  void exampleActivation();
  void startRecording();
  void stopRecording();
  void moveToNextExamples(int examplePinter);
  get isThereNextWord => null;
}

abstract class MicStateBase {
  final int countPron;
  final bool activateExample;
  final int examplePinter;
  final String micMessage;
  final bool isAnalyzing;

  MicStateBase(
      {required this.countPron,
      required this.activateExample,
      required this.examplePinter,
      required this.isAnalyzing,
      required this.micMessage});

  MicStateBase copyWith(
      {int? countPron,
      bool? activateExample,
      int? examplePinter,
      bool? isAnalyzing,
      String? micMessage});
}
