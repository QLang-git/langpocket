import 'package:flutter/material.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/microphone_controller.dart';

class MicrophoneButton extends StatefulWidget {
  final MicrophoneController microphoneController;

  const MicrophoneButton({Key? key, required this.microphoneController})
      : super(key: key);

  @override
  State<MicrophoneButton> createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
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
        onLongPressStart: (_) {
          widget.microphoneController.startRecording();
          setState(() {
            isRecording = true;
          });
        },
        onLongPressEnd: (_) {
          widget.microphoneController.stopRecording();
          isRecording = false;
        },
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
                  return Container(
                    width: isRecording ? 150.0 : 150.0 * _animation.value,
                    height: isRecording ? 150.0 : 150.0 * _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
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
