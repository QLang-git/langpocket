import 'package:langpocket/src/utils/routes/app_routes.dart';

class AudioController {
  final List<WordRecord> wordRecords;

  AudioController({required this.wordRecords});

  void initialization() {}

  List<String> _organizeText() {
    //final tts = TextToSpeech();
    final List<String> text = [];
    wordRecords.map((word) {
      // todo: implement the tts
    }).toList();

    return text;
  }
}
