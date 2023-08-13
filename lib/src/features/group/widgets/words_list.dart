import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/features/group/controller/group_controller.dart';
import 'package:langpocket/src/features/group/widgets/custom_practice_dialog.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordsList extends ConsumerStatefulWidget {
  final int groupId;
  final GroupController groupController;
  final List<WordRecord> words;

  const WordsList({
    required this.groupId,
    required this.words,
    required this.groupController,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<WordsList> createState() => _WordsGroupsState();
}

class _WordsGroupsState extends ConsumerState<WordsList> {
  @override
  Widget build(BuildContext context) {
    return widget.words.isEmpty
        ? const Center(child: Text('No Word saved in This Group'))
        : _MyWordList(
            groupId: widget.groupId,
            words: widget.words,
            groupController: widget.groupController,
          );
  }
}

class _MyWordList extends ConsumerStatefulWidget {
  final List<WordRecord> words;
  final int groupId;
  final GroupController groupController;

  const _MyWordList({
    required this.groupId,
    required this.words,
    required this.groupController,
    Key? key,
  }) : super(key: key);

  @override
  _MyWordListState createState() => _MyWordListState();
}

class _MyWordListState extends ConsumerState<_MyWordList> {
  late List<WordRecord> myWords;

  @override
  void initState() {
    super.initState();
    myWords = widget.words;
  }

  void _onDismissed(int index, WordRecord word) {
    final wordTarget = word;
    setState(() {
      myWords.removeAt(index);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: const Text("The word has been deleted"),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: "Undo",
              textColor: Colors.yellow,
              onPressed: () {
                if (mounted) {
                  setState(() {
                    myWords.insert(index, wordTarget);
                  });
                }
              },
            ),
          ),
        )
        .closed
        .then((reason) {
      if (reason != SnackBarClosedReason.action) {
        _deleteWord(word.id!, widget.groupId);
      }
    });
  }

  Future<void> _deleteWord(int wordId, int groupId) async {
    try {
      widget.groupController.deleteWord(wordId, groupId);
      // Deletion succeeded
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete word: Try again"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myWords.length,
      itemBuilder: (context, index) {
        final word = myWords[index];
        return DismissibleWordCard(
          word: word,
          onDismissed: () => _onDismissed(index, word),
        );
      },
    );
  }
}

class DismissibleWordCard extends StatelessWidget {
  final WordRecord word;
  final VoidCallback onDismissed;

  const DismissibleWordCard({
    required this.word,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(word.id),
      background: const DeleteBackground(),
      onDismissed: (_) => onDismissed(),
      child: WordCard(
        word: word,
      ),
    );
  }
}

class DeleteBackground extends StatelessWidget {
  const DeleteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final WordRecord word;

  const WordCard({
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomExample = Random().nextInt(word.wordExamples.length);
    final tts = TextToSpeech();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          final groupId = GoRouterState.of(context).pathParameters["groupId"];
          context.pushNamed(AppRoute.word.name, pathParameters: {
            "groupId": groupId!,
            'wordId': word.id.toString()
          });
        },
        onLongPress: () {
          const double padding = 20;
          const double avatarRadius = 45;
          showDialog(
            context: context,
            builder: (BuildContext buildContext) => CustomPracticeDialog(
              groupId: GoRouterState.of(context).pathParameters["groupId"]!,
              wordData: word,
              padding: padding,
              avatarRadius: avatarRadius,
            ),
          );
        },
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              SizedBox(
                height: double.infinity,
                width: 90,
                child: word.wordImages.isNotEmpty
                    ? Image(
                        image: FileImage(File(word.wordImages.first)),
                        fit: BoxFit.fill,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.indigo[600]),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Center(
                            child: Text(word.wordMeans.first,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    letterSpacing: 1.5,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                // Add this
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.foreignWord,
                        style: headline3Bold(primaryFontColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text('Means: ', style: bodyLarge(primaryFontColor)),
                          Expanded(
                            // And this
                            child: Text(
                              word.wordMeans.join(','),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: bodyLargeBold(secondaryColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Example: ', style: bodyLarge(primaryFontColor)),
                          Expanded(
                            // And this
                            child: Text(
                              word.wordExamples[randomExample],
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: bodyLargeBold(secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    tts.setRate(1);
                    tts.speak(word.foreignWord);
                  },
                  icon: Icon(
                    Icons.volume_up_outlined,
                    color: Theme.of(context).colorScheme.outline,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
