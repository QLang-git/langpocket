abstract class MicrophoneConst {
  int get countWordPron;
  int get countExamplePron;
  String get initialMessage;
  String get exampleActivationMessage;
}

class ConstPronMicrophone extends MicrophoneConst {
  @override
  int get countWordPron => 4;
  @override
  int get countExamplePron => 3;

  @override
  String get initialMessage => "Hold to Start Recording ...";

  @override
  String get exampleActivationMessage =>
      "Try to Pronounce the following sentence ";
}

class ConstListenRepeatMicrophone extends MicrophoneConst {
  @override
  int get countWordPron => 1;

  @override
  int get countExamplePron => 1;

  @override
  String get initialMessage => "Now your turn : Hold to Start Recording ...";

  @override
  String get exampleActivationMessage =>
      "Now your turn : Try to Pronounce the sentence ";
}

class ConstReadSpeakMicrophone extends MicrophoneConst {
  @override
  int get countWordPron => 1;

  @override
  int get countExamplePron => 1;

  @override
  String get initialMessage => "Read the Word : Hold to Start Recording ...";

  @override
  String get exampleActivationMessage =>
      "Read the sentence  : Hold to Start Recording ...";
}
