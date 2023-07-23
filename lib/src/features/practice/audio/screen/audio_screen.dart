import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/practice/audio/controller/audio_controller.dart';
import 'package:langpocket/src/features/practice/audio/screen/audio_appbar.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class AudioScreen extends StatefulWidget {
  final String groupName;
  final List<WordRecord> words;

  const AudioScreen({super.key, required this.words, required this.groupName});

  @override
  State<AudioScreen> createState() => AudioScreenState();
}

class AudioScreenState extends State<AudioScreen> {
  late AudioController audioController;
  bool isSoundPlaying = false;

  @override
  void initState() {
    audioController = AudioController(
      wordRecords: widget.words,
      soundPlaying: setSoundPlaying,
    );
    super.initState();
    audioController.playAudio();
  }

  void setSoundPlaying(bool state) => setState(() {
        isSoundPlaying = state;
      });

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return ResponsiveCenter(
        child: Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const AudioAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: colorScheme.error,
                  ),
                  child: Text(
                    "This feature is exclusively designed for mobile devices, allowing you to convert words and sentences into MP3 audio clips. You can easily navigate through the audio and even listen to it in the background",
                    style: textTheme.labelMedium?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: colorScheme.secondary,
                    ),
                    height: 500,
                    child: const Center(
                      child: Icon(
                        Icons.music_note_rounded,
                        color: Colors.white,
                        size: 95,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(15)),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      height: 80,
                      child: Center(
                        child: Text(
                          widget.groupName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colorScheme.secondary.withOpacity(0.8),
                ),
                height: 100,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: const IconThemeData(
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.skip_previous)),
                      isSoundPlaying
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.play_disabled,
                                color: Colors.white,
                              ))
                          : IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.play_circle)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.skip_next)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
