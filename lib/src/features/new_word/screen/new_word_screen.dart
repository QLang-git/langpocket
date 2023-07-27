import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/new_word/widgets/form/word_form.dart';
import 'package:langpocket/src/features/new_word/app_bar/new_word_appbar.dart';
import 'package:langpocket/src/features/new_word/widgets/form/fields/images_dashboard.dart';

class NewWordScreen extends StatefulWidget {
  const NewWordScreen({super.key});

  @override
  State<NewWordScreen> createState() => NewWordScreenState();
}

class NewWordScreenState extends State<NewWordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    return ResponsiveCenter(
        child: Scaffold(
            backgroundColor: colorStyle.background,
            appBar: NewWordAppBar(
              formKey: formKey,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 19.5),
                child: Column(
                  children: [
                    const ImagesDashboard(),
                    const SizedBox(
                      height: 40,
                    ),
                    NewWordForm(formKey: formKey),
                  ],
                ),
              ),
            ),
            floatingActionButton: Consumer(
              builder: (context, ref, child) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () async {
                  //! 1- Validate returns true if the form is valid, or false otherwise.
                  if (formKey.currentState!.validate()) {
                    //! 2-save the word in db
                    await ref
                        .read(newWordControllerProvider.notifier)
                        .saveNewWord(DateTime.now())
                        .then((_) {
                      formKey.currentState?.reset();
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('The word has been saved')),
                      );
                    });
                  }
                },
                child: SizedBox(
                  width: 120, // Adjust this value
                  height: 45,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.save_alt_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Save',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
