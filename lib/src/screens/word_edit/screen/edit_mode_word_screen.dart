import 'package:flutter/material.dart';

class EditModeWordScreen extends StatelessWidget {
  final List<String> imageList;
  final String foreignWord;
  final List<String> means;
  final List<String> examples;
  final String note;
  const EditModeWordScreen(
      {super.key,
      required this.imageList,
      required this.foreignWord,
      required this.means,
      required this.examples,
      required this.note});

  @override
  Widget build(BuildContext context) {
    return const Text('Welcome to word edit mode :))');
  }
}
