import 'package:flutter/material.dart';
import 'package:langpocket/src/screens/practice/pronunciation/controllers/mic_single_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StepsMicrophoneButton extends StatefulWidget {
  final bool activation;
  final bool? isAnalyzing;
  final MicSingleController microphoneController;

  const StepsMicrophoneButton(
      {Key? key,
      required this.microphoneController,
      required this.activation,
      required this.isAnalyzing})
      : super(key: key);

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
        widget.isAnalyzing != null && widget.isAnalyzing == true;
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
        backgroundColor: !widget.activation ? Colors.grey : Colors.indigo[500],
        elevation: 0,
        child: wordAnalyze && widget.activation
            ? Container(
                child: LoadingAnimationWidget.bouncingBall(
                    color: Colors.white, size: 40))
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
