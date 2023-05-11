import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/microphone_controller.dart';

class MicrophoneButton extends StatefulWidget {
  final MicrophoneController controller;

  const MicrophoneButton({Key? key, required this.controller})
      : super(key: key);

  @override
  State<MicrophoneButton> createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    widget.controller.initializeSpeechToText();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 150,
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onLongPressStart: (_) => widget.controller.startRecording(),
        onLongPressEnd: (_) => widget.controller.stopRecording(),
        child: FloatingActionButton(
          onPressed: null, // Disabled regular tap
          backgroundColor: Colors.indigo[500],
          elevation: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Consumer(
                    builder: (context, ref, child) {
                      final recording = ref.watch(recordingProvider);
                      return Container(
                        width: recording ? 150.0 : 150.0 * _animation.value,
                        height: recording ? 150.0 : 150.0 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                        ),
                      );
                    },
                  );
                },
              ),
              const Icon(Icons.mic, size: 70.0),
            ],
          ),
        ),
      ),
    );
  }
}
