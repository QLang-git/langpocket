import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordAnalyze =
        widget.microphoneController.currentStatus == RecordingStatus.analyze;
    return Container(
      height: 170,
      width: 150,
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onLongPressStart: wordAnalyze
            ? null
            : (_) {
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
          backgroundColor: wordAnalyze ? Colors.grey : Colors.indigo[500],
          elevation: 20,
          child: wordAnalyze
              ? Container(
                  child: LoadingAnimationWidget.inkDrop(
                      color: const Color(0xFF3F51B5), size: 70))
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        return Container(
                          width: isRecording ? 150.0 : 150.0 * _animation.value,
                          height:
                              isRecording ? 150.0 : 150.0 * _animation.value,
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
