import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/global_states.dart';

class MeanWord extends StatelessWidget {
  final bool isAdditional;
  const MeanWord({
    Key? key,
    required this.isAdditional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: headline3(primaryFontColor),
      decoration: InputDecoration(
        suffixIcon: isAdditional
            ? Consumer(builder: (context, ref, child) {
                return TextButton(
                  onPressed: () =>
                      ref.read(numberOfMeaningProvider.notifier).state -= 1,
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
      validator: !isAdditional
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter one meaning for this word';
              }
              return null;
            }
          : null,
    );
  }
}
