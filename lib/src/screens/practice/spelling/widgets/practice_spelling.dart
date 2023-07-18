import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/common_widgets/views/word_view/word_view.dart';
import 'package:langpocket/src/screens/practice/spelling/controllers/spelling_controller.dart';
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
    return Column(
      children: [
        ImageView(imageList: wordImages),
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
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(10),
                child: const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Ionicons.eye_off,
                        size: 40,
                      ),
                    )),
              ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 6,
                  child: TextField(
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
              Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  shape: const CircleBorder(),
                  color: Colors.indigo[400],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: !activateExample
                        ? Text(
                            countSpelling.toString(),
                            style: textTheme.labelLarge
                                ?.copyWith(color: Colors.white),
                          )
                        : Text(
                            0.toString(),
                            style: textTheme.labelLarge
                                ?.copyWith(color: Colors.white),
                          ),
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        activateExample
            ? Column(children: [
                countSpelling < 2
                    ? Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Icon(
                                Ionicons.eye_off,
                                size: 40,
                              ),
                            )),
                      )
                    : Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  wordExamples[examplePinter],
                                  style: textTheme.headlineLarge
                                      ?.copyWith(color: colorScheme.outline),
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                ),
                              ]),
                        ),
                      ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 6,
                          child: TextField(
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
                      Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          shape: const CircleBorder(),
                          color: Colors.indigo[400],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              countSpelling.toString(),
                              style: textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                )
              ])
            : Container()
      ],
    );
  }
}
