import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/global_states.dart';

class ExampleWord extends StatefulWidget {
  final int exampleNumber;
  final List<String> examples;
  const ExampleWord(
      {super.key, required this.exampleNumber, required this.examples});

  @override
  State<ExampleWord> createState() => _ExampleWordState();
}

class _ExampleWordState extends State<ExampleWord> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Consumer(
        builder: (context, ref, child) {
          return TextFormField(
            style: headline3(primaryFontColor),
            decoration: InputDecoration(
              suffixIcon: widget.exampleNumber > 2
                  ? Consumer(builder: (context, ref, child) {
                      return TextButton(
                        onPressed: () => ref
                            .read(numberOfExamplesProvider.notifier)
                            .state -= 1,
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
            validator: widget.exampleNumber < 3
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the word';
                    } else {
                      widget.examples.add(value);
                      ref.read(examplesProvider.notifier).state =
                          widget.examples;
                    }
                    return null;
                  }
                : ((value) {
                    if (value != null) {
                      widget.examples.add(value);
                      ref.read(examplesProvider.notifier).state =
                          widget.examples;
                    }

                    return null;
                  }),
          );
        },
      ),
    );
  }
}
