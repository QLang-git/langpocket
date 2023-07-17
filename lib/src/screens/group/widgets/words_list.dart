import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/screens/group/widgets/custom_practice_dialog.dart';
import 'package:langpocket/src/screens/group/widgets/word_info.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordsGroups extends ConsumerStatefulWidget {
  final GroupController groupController;
  final List<WordRecord> words;
  const WordsGroups({
    required this.words,
    required this.groupController,
    super.key,
  });

  @override
  ConsumerState<WordsGroups> createState() => WordsGroupsState();
}

class WordsGroupsState extends ConsumerState<WordsGroups> {
  @override
  Widget build(BuildContext context) {
    return widget.words.isEmpty
        ? const Center(child: Text('No Word saved in This Group'))
        : _MyWordList(
            words: widget.words,
            groupController: widget.groupController,
          );
  }
}

class _MyWordList extends ConsumerStatefulWidget {
  final List<WordRecord> words;
  final GroupController groupController;

  const _MyWordList({
    required this.words,
    required this.groupController,
  });

  @override
  ConsumerState<_MyWordList> createState() => __MyWordListState();
}

class __MyWordListState extends ConsumerState<_MyWordList> {
  late List<WordRecord> myWords;

  final tts = TextToSpeech();

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
        _deleteWord(word.id!);
      }
    });
  }

  Future<void> _deleteWord(int wordId) async {
    try {
      widget.groupController.deleteWord(wordId);
      // Deletion succeeded
    } catch (error) {
      // Handle deletion failure
      print("Failed to delete word: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: myWords.length,
        itemBuilder: (context, index) {
          final word = myWords[index];

          return Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey(word.id),
            background: Container(
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
            onDismissed: (_) => _onDismissed(index, word),
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  final groupId =
                      GoRouterState.of(context).pathParameters["groupId"];
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
                    builder: (BuildContext buildContext) =>
                        CustomPracticeDialog(
                      groupId:
                          GoRouterState.of(context).pathParameters["groupId"]!,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WordInfo(word: word),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
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
            ),
          );
        },
      ),
    );
  }
}
