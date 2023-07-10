import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/practice/audio/screen/audio_appbar.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class AudioScreen extends StatefulWidget {
  final List<WordRecord> words;

  const AudioScreen({
    super.key,
    required this.words,
  });

  @override
  State<AudioScreen> createState() => AudioScreenState();
}

class AudioScreenState extends State<AudioScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ResponsiveCenter(
        child: Scaffold(
      appBar: AudioAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Column(
            children: [Text('play the audio ')],
          ),
        ),
      ),
    ));
  }
}
