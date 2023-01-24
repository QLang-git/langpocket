import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class MeanWord extends StatelessWidget {
  const MeanWord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          style: headline3(primaryFontColor),

          decoration: InputDecoration(
            suffixIcon: Padding(
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter one meaning for this word';
            }
            return null;
          },
        ),
      ),
    );
  }
}
