import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/form/word_form.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/home_app_bar/presentation/new_word_appbar.dart';
import 'package:langpocket/src/screens/new_word/presntation/utils/image_picker/image_previewer.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NewWordScreen extends StatelessWidget {
  const NewWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: This is a GlobalKey<FormState>,
    // not a GlobalKey<MyCustomFormState>.
    final formKey = GlobalKey<FormState>();
    return ResponsiveCenter(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: const NewWordAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const ImagePreviewer(),
                const SizedBox(
                  height: 40,
                ),
                NewWordForm(formKey: formKey),
              ],
            ),
          ),
        ),
        floatingActionButton: Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  textStyle: buttonStyle(buttonColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('The word has been saved')),
                  );
                }
              },
              child: SizedBox(
                width: 90,
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save_alt_outlined),
                      SizedBox(width: 5),
                      Text('Save'),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
