import 'package:flutter/material.dart';

class PracticeStepperController {
  final List<Widget> steps;
  final ValueChanged<int> moveToNext;
  final ValueChanged<int> moveToPrevious;
  int _currentStep = 0;

  PracticeStepperController(
      {required this.moveToNext,
      required this.moveToPrevious,
      required this.steps});

  int initialStep() => _currentStep;

  void goToNext() {
    if (_currentStep < steps.length) {
      _currentStep += 1;
      moveToNext(_currentStep);
    }
  }

  void goToPrevious() {
    if (_currentStep > steps.length) {
      _currentStep -= 1;
      moveToNext(_currentStep);
    }
  }
}
