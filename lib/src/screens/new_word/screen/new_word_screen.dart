import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/new_word/controller/save_word_controller.dart';
import 'package:langpocket/src/screens/new_word/widgets/form/word_form.dart';
import 'package:langpocket/src/screens/new_word/app_bar/new_word_appbar.dart';
import 'package:langpocket/src/screens/new_word/widgets/image_picker/images_dashboard.dart';

class NewWordScreen extends StatefulWidget {
  const NewWordScreen({super.key});

  @override
  State<NewWordScreen> createState() => NewWordScreenState();
}

class NewWordScreenState extends State<NewWordScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> wordMeans = List.filled(6, '');
  List<Uint8List> wordImages = [];
  List<String> wordExample = List.filled(6, '');
  String wordNote = '';
  String foreignWord = '';

  void setWordMeans(String means, int targetIndex) {
    setState(() {
      wordMeans[targetIndex] = means;
    });
  }

  void setWordExample(String example, int targetIndex) {
    setState(() {
      wordExample[targetIndex] = example;
    });
  }

  void setWordImages(List<Uint8List> images) {
    setState(() {
      wordImages = images;
    });
  }

  void setForeignWord(String word) {
    setState(() {
      foreignWord = word;
    });
  }

  void setNote(String note) {
    setState(() {
      wordNote = note;
    });
  }

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
                onPressed: () {
                  //! 1- Validate returns true if the form is valid, or false otherwise.
                  if (formKey.currentState!.validate()) {
                    //! 2-save the word in db
                    final imagesbase64 =
                        wordImages.map((img) => base64Encode(img)).toList();
                    ref.read(saveWordControllerProvider.notifier).addNewWord(
                          foreignWord: foreignWord,
                          wordMeans: wordMeans.join('-'),
                          wordImages: imagesbase64.join('-'),
                          wordExamples: wordExample.join('-'),
                          wordNote: wordNote,
                        );
                    //! 3-clear states and word's form if saved successed
                    setState(() {
                      foreignWord = '';
                      wordMeans = List.filled(6, '');
                      wordImages = [];
                      wordExample = List.filled(6, '');
                      wordNote = '';
                    });
                    formKey.currentState?.reset();
                    context.pop();
                    // state.when(
                    //     data: (saved) {
                    //       ref.read(foreignProvider.notifier).state = '';
                    //       ref.read(meansProvider.notifier).state = [];
                    //       ref.read(examplesProvider.notifier).state = [];
                    //       ref.read(noteProvider.notifier).state = '';
                    //       formKey.currentState?.reset();
                    //       return ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(
                    //             content: Text('The word has been saved')),
                    //       );
                    //     },
                    //     error: ((error, stackTrace) =>
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           const SnackBar(
                    //               content:
                    //                   Text('The Word is not saved, Try again')),
                    //         )),
                    //     loading: () => ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(content: CircularProgressIndicator())));

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('The word has been saved')),
                    );
                  }
                },
                child: SizedBox(
                  width: 90,
                  height: 45,
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
            )));
  }
}
