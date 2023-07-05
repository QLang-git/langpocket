import 'package:flutter/material.dart';
import 'package:langpocket/src/common_controller/microphone_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StepsMicrophoneButton extends StatefulWidget {
  final bool activation;
  final MicrophoneController microphoneController;

  const StepsMicrophoneButton({
    Key? key,
    required this.microphoneController,
    required this.activation,
  }) : super(key: key);

  @override
  State<StepsMicrophoneButton> createState() => _StepsMicrophoneButtonState();
}

class _StepsMicrophoneButtonState extends State<StepsMicrophoneButton>
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
    return GestureDetector(
      onLongPressStart: wordAnalyze || !widget.activation
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
        backgroundColor: wordAnalyze
            ? Colors.transparent
            : widget.activation
                ? Colors.indigo[500]
                : Colors.grey,
        elevation: 0,
        child: wordAnalyze && widget.activation
            ? Container(
                child: LoadingAnimationWidget.bouncingBall(
                    color: const Color(0xFF3F51B5), size: 40))
            : widget.activation
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (BuildContext context, Widget? child) {
                          return Container(
                            width:
                                isRecording ? 150.0 : 150.0 * _animation.value,
                            height:
                                isRecording ? 150.0 : 150.0 * _animation.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                            ),
                          );
                        },
                      ),
                      const Icon(Icons.mic),
                    ],
                  )
                : const Icon(Icons.mic),
      ),
    );
  }
}
