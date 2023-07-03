abstract class MicrophoneConst {
  int get countWordPron;
  int get countExamplePron;
  String get initialMessage;
}

class ConstPronMicrophone extends MicrophoneConst {
  @override
  int get countWordPron => 4;
  @override
  int get countExamplePron => 3;

  @override
  String get initialMessage => "Hold to Start Recording ...";
}

class ConstIterMicrophone extends MicrophoneConst {
  @override
  int get countWordPron => 1;

  @override
  int get countExamplePron => 1;

  @override
  String get initialMessage => "Now your turn : Hold to Start Recording ...";
}
