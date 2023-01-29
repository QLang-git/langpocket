import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class MeanWord extends StatefulWidget {
  const MeanWord({
    Key? key,
  }) : super(key: key);

  @override
  State<MeanWord> createState() => _MeanWordState();
}

class _MeanWordState extends State<MeanWord> {
  final meaningControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(children: [
          for (int i = 0; i < meaningControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextFormField(
                controller: meaningControllers[i],
                style: headline3(primaryFontColor),
                decoration: InputDecoration(
                  suffixIcon: i > 0
                      ? TextButton(
                          onPressed: () {
                            meaningControllers[i].clear();
                            ref.read(meansProvider.notifier).state[i] = '';

                            ref.read(meansProvider.notifier).state[i + 1] = '';
                            setState(() {
                              meaningControllers.removeAt(i);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Icon(
                              Icons.close_outlined,
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Icon(
                            Icons.language_outlined,
                            color: primaryColor,
                          ),
                        ),
                  labelStyle: bodyLarge(primaryColor),
                  label: const Text('Mean'),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: secondaryColor),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: meaningControllers[i] == meaningControllers.first
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter one meaning for this word';
                        } else {
                          ref.read(meansProvider.notifier).state[i] = value;
                        }
                        return null;
                      }
                    : ((value) {
                        if (value != null) {
                          ref.read(meansProvider.notifier).state[i] = value;
                        }
                        return null;
                      }),
              ),
            ),
          if (meaningControllers.length < 3)
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: buttonColor,
                shape: const CircleBorder(),
              ),
              onPressed: () {
                setState(() {
                  meaningControllers.add(TextEditingController());
                });
              },
              child: const Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              ),
            ),
        ]);
      },
    );
  }
}
