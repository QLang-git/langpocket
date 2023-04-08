import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/screens/group/widgets/custom_practice_dialog.dart';
import 'package:langpocket/src/screens/group/widgets/word_info.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/controller/groups_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordsGroups extends ConsumerStatefulWidget {
  final String groupName;
  final String date;
  final int groupId;
  const WordsGroups(
      {required this.groupName,
      required this.date,
      super.key,
      required this.groupId});

  @override
  ConsumerState<WordsGroups> createState() => _WordsGroupsState();
}

class _WordsGroupsState extends ConsumerState<WordsGroups> {
  @override
  Widget build(BuildContext context) {
    final wordsList = ref.watch(watchWordsListbyIdProvider(widget.groupId));
    return AsyncValueWidget(
        value: wordsList,
        data: (currentWords) {
          if (currentWords.isEmpty) {
            return const Center(child: Text('No Word saved in This Group'));
          }

          return _MyWordList(
            words: wordDecoding(currentWords),
            groupName: widget.groupName,
            date: widget.date,
            groupId: widget.groupId,
            context: context,
          );
        });
  }
}

class _MyWordList extends ConsumerStatefulWidget {
  final BuildContext context;

  final List<Word> words;
  final String groupName;
  final String date;
  final int groupId;
  const _MyWordList({
    required this.words,
    required this.groupName,
    required this.date,
    required this.groupId,
    required this.context,
  });

  @override
  ConsumerState<_MyWordList> createState() => __MyWordListState();
}

class __MyWordListState extends ConsumerState<_MyWordList> {
  late List<Word> myWords;

  final tts = TextToSpeech();
  @override
  void initState() {
    myWords = widget.words;
    super.initState();
  }

  void _onDismissed(int index, Word word) async {
    final wordTarget = word;
    setState(() {
      myWords.removeAt(index);
    });
    ScaffoldMessenger.of(widget.context)
        .showSnackBar(SnackBar(
            content: const Text("The word has been deleted"),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
                label: "Undo",
                textColor: Colors.yellow,
                onPressed: () {
                  setState(() {
                    myWords.insert(index, wordTarget);
                  });
                })))
        .closed
        .then((reason) async {
      if (reason != SnackBarClosedReason.action) {
        deleteWord(word.id!, widget.groupId);
        // update this line
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    myWords = widget.words;

    return ListView.builder(
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
                      )
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
                  context.pushNamed(AppRoute.word.name,
                      params: {'id': word.id.toString()});
                },
                onLongPress: () {
                  const double padding = 20;
                  const double avatarRadius = 45;
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) =>
                          CustomPracticeDialog(
                            wordData: word,
                            padding: padding,
                            avatarRadius: avatarRadius,
                            date: widget.date,
                            name: widget.groupName,
                            groupId: widget.groupId.toString(),
                          ));
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
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
