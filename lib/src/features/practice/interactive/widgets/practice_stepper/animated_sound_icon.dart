import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedSoundIcon extends StatefulWidget {
  final bool micActivation;

  const AnimatedSoundIcon({Key? key, required this.micActivation})
      : super(key: key);

  @override
  State<AnimatedSoundIcon> createState() => _AnimatedSoundIconState();
}

class _AnimatedSoundIconState extends State<AnimatedSoundIcon>
    with TickerProviderStateMixin {
  late AnimationController _soundAnimationController;

  @override
  void initState() {
    super.initState();

    _soundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    if (!widget.micActivation) {
      _soundAnimationController.repeat();
    }
  }

  @override
  void dispose() {
    _soundAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedSoundIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.micActivation) {
      _soundAnimationController.stop();
    } else {
      _soundAnimationController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _soundAnimationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _soundAnimationController.value * 2 * pi,
          child: child,
        );
      },
      child: const Icon(Icons.headset),
    );
  }
}
