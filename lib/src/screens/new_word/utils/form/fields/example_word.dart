import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/global_states.dart';

class ExampleWord extends StatelessWidget {
  final int exampleNumber;
  const ExampleWord({super.key, required this.exampleNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: headline3(primaryFontColor),
        decoration: InputDecoration(
          suffixIcon: exampleNumber > 2
              ? Consumer(builder: (context, ref, child) {
                  return TextButton(
                    onPressed: () =>
                        ref.read(numberOfExamplesProvider.notifier).state -= 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Icon(
                        Icons.close_outlined,
                        color: primaryColor,
                      ),
                    ),
                  );
                })
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Icon(
                    Icons.language_outlined,
                    color: primaryColor,
                  ),
                ),
          labelStyle: bodyLarge(primaryColor),
          label: Text('example $exampleNumber'),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: secondaryColor),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        // The validator receives the text that the user has entered.
        validator: exampleNumber < 3
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the word';
                }
                return null;
              }
            : null,
      ),
    );
  }
}
