import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class ExampleWord extends StatefulWidget {
  final int exampleNumber;
  const ExampleWord({super.key, required this.exampleNumber});

  @override
  State<ExampleWord> createState() => _ExampleWordState();
}

class _ExampleWordState extends State<ExampleWord> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: headline3(primaryFontColor),
        decoration: InputDecoration(
          labelStyle: bodyLarge(primaryColor),
          label: Text('example ${widget.exampleNumber}'),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: secondaryColor),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the word';
          }
          return null;
        },
      ),
    );
  }
}
