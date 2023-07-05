import 'package:flutter/material.dart';

class PracticeStepperController {
  final List<Widget> steps;
  final ValueChanged<int> moveToNext;
  int _currentStep = 1;

  PracticeStepperController({required this.moveToNext, required this.steps});

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
