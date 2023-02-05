import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/new_word/controller/save_word_controller.dart';
import 'package:langpocket/src/screens/new_word/widgets/form/word_form.dart';
import 'package:langpocket/src/screens/new_word/app_bar/new_word_appbar.dart';
import 'package:langpocket/src/screens/new_word/widgets/image_picker/images_dashboard.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NewWordScreen extends StatefulWidget {
  const NewWordScreen({super.key});

  @override
  State<NewWordScreen> createState() => NewWordScreenState();
}

class NewWordScreenState extends State<NewWordScreen> {
  final formKey = GlobalKey<FormState>();
  List<String> wordMeans = List.filled(6, '');
  List<String> wordImages = [];
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

  void setWordImages(List<String> images) {
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
    return ResponsiveCenter(
        child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: NewWordAppBar(
              formKey: formKey,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
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
                    backgroundColor: buttonColor,
                    textStyle: buttonStyle(buttonColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  //! 1- Validate returns true if the form is valid, or false otherwise.
                  if (formKey.currentState!.validate()) {
                    //! 2-save the word in db
                    ref.read(saveWordControllerProvider.notifier).addNewWord(
                          foreignWord: foreignWord,
                          wordMeans: wordMeans.join('-'),
                          wordImages: wordImages.join('-'),
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
                  height: 70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.save_alt_outlined),
                        SizedBox(width: 5),
                        Text('Save'),
                      ]),
                ),
              ),
            )));
  }
}
