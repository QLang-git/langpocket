import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/custom_text_form_field.dart';
import 'package:langpocket/src/common_widgets/views/examples_view/example_view.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class PracticeSpelling<T extends SpellingStateBase> extends StatelessWidget {
  final TextEditingController exampleInputController;
  final TextEditingController inputController;
  final bool readOnlyWord;
  final WordRecord wordRecord;
  final SpellingController<T> spellingController;
  final T spellingState;
  final bool readOnlyExample;
  const PracticeSpelling(
      {super.key,
      required this.exampleInputController,
      required this.inputController,
      required this.wordRecord,
      required this.readOnlyWord,
      required this.spellingController,
      required this.readOnlyExample,
      required this.spellingState});

  @override
  Widget build(BuildContext context) {
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);
    final WordRecord(
      :wordImages,
      :foreignWord,
      :wordExamples,
      :wordMeans,
    ) = wordRecord;
    final T(:activateExample, :correctness, :countSpelling, :examplePinter) =
        spellingState;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ImageView(
            imageList: wordImages,
            meanings: wordMeans,
          ),
          const SizedBox(
            height: 15,
          ),
          countSpelling > 3 || activateExample
              ? WordView(
                  foreignWord: foreignWord,
                  means: wordMeans,
                  noVoiceIcon: true,
                )
              : Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                        width: double.infinity,
                        child: Icon(
                          Ionicons.eye_off,
                          size: 30,
                        )),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 6,
                  child: CustomTextField(
                    enableIMEPersonalizedLearning: false,
                    enableSuggestions: false,
                    autocorrect: false,
                    readOnly: readOnlyWord,
                    controller: inputController,
                    onChanged: (value) {
                      spellingController.comparingTexts(value);
                    },
                    style: textTheme.headlineMedium
                        ?.copyWith(color: colorScheme.outline),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      filled: true,
                      fillColor: correctness || activateExample
                          ? const Color.fromARGB(255, 104, 198, 107)
                          : null,
                      labelStyle: textTheme.bodyLarge
                          ?.copyWith(color: colorScheme.outline),
                      label: const Text('Write it down'),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: colorScheme.onSurface),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                  )),
              Expanded(
                flex: 1,
                child: Card(
                    elevation: 5,
                    shape: const CircleBorder(),
                    color: Colors.indigo[400],
                    child: !activateExample
                        ? Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              countSpelling.toString(),
                              textAlign: TextAlign.center,
                              style: textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              0.toString(),
                              style: textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          activateExample
              ? Column(children: [
                  countSpelling < 2
                      ? Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                width: double.infinity,
                                child: Icon(
                                  Ionicons.eye_off,
                                  size: 30,
                                )),
                          ),
                        )
                      : ExampleView(
                          example: wordExamples[examplePinter],
                          noVoiceIcon: true,
                        ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 6,
                          child: CustomTextField(
                            enableIMEPersonalizedLearning: false,
                            enableSuggestions: false,
                            autocorrect: false,
                            readOnly: readOnlyExample,
                            controller: exampleInputController,
                            onChanged: (value) =>
                                spellingController.comparingTexts(value),
                            style: textTheme.headlineMedium
                                ?.copyWith(color: colorScheme.outline),
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              fillColor: correctness
                                  ? const Color.fromARGB(255, 104, 198, 107)
                                  : null,
                              labelStyle: textTheme.bodyMedium
                                  ?.copyWith(color: colorScheme.onSurface),
                              label: const Text('Write it down'),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: colorScheme.onSurface),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                          )),
                      Expanded(
                        flex: 1,
                        child: Card(
                            elevation: 5,
                            shape: const CircleBorder(),
                            color: Colors.indigo[400],
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text(
                                countSpelling.toString(),
                                textAlign: TextAlign.center,
                                style: textTheme.labelLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  )
                ])
              : Container()
        ],
      ),
    );
  }
}
