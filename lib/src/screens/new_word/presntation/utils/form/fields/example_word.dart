import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class ExampleWord extends StatefulWidget {
  const ExampleWord({super.key});

  @override
  State<ExampleWord> createState() => _ExampleWordState();
}

class _ExampleWordState extends State<ExampleWord> {
  final exampleControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            child: Text(
              '+ Add examples',
              style: headline2Bold(primaryFontColor),
            ),
          ),
        ),
        for (int i = 0; i < exampleControllers.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: exampleControllers[i],
              style: headline3(primaryFontColor),
              decoration: InputDecoration(
                suffixIcon: i > 1
                    ? Consumer(builder: (context, ref, child) {
                        return TextButton(
                          onPressed: () {
                            exampleControllers[i].clear();
                            ref.read(examplesProvider.notifier).state[i] = '';

                            ref.read(examplesProvider.notifier).state[i + 1] =
                                '';
                            setState(() {
                              exampleControllers.remove(exampleControllers[i]);
                            });
                          },
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
                label: Text('example ${i + 1}'),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: secondaryColor),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: exampleControllers[i] == exampleControllers.first
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter one meaning for this word';
                      } else {
                        ref.read(examplesProvider.notifier).state[i] = value;
                      }
                      return null;
                    }
                  : ((value) {
                      if (value != null) {
                        ref.read(examplesProvider.notifier).state[i] = value;
                      }
                      return null;
                    }),
            ),
          ),
        if (exampleControllers.length < 5)
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              shape: const CircleBorder(),
            ),
            onPressed: () {
              setState(() {
                exampleControllers.add(TextEditingController());
              });
            },
            child: const Icon(
              Icons.add,
              size: 50,
              color: Colors.white,
            ),
          ),
      ]);
    });
  }
}
