import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/word_edit/controller/word_editor_controller.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordEditorAppbar extends StatefulWidget with PreferredSizeWidget {
  final List<String> imageList;
  final String foreignWord;
  final List<String> means;
  final List<String> examples;
  final String note;
  const WordEditorAppbar({
    super.key,
    required this.imageList,
    required this.foreignWord,
    required this.means,
    required this.examples,
    required this.note,
  });

  @override
  State<WordEditorAppbar> createState() => _WordEditorAppbarState();
  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _WordEditorAppbarState extends State<WordEditorAppbar> {
  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<EditModeWordScreenState>()!;
    List<String> cleanList(List<String> list) {
      return list.where((element) => element.isNotEmpty).toList();
    }

    Future<void> saveNewUpdate(WidgetRef ref) async {
      final newInfo = NewWordInfo(
          1,
          WordCompanion(
            foreignWord: Value(states.updatedforeignWord),
            wordMeans: Value(states.updatedWordMeans.join('-')),
            wordImages: Value(states.updatedWordImages.join('-')),
            wordExamples: Value(states.updatedWordExample.join('-')),
            wordNote: Value(states.updatedWordNote),
          ));

      ref.read(updateWordInfoProvider(newInfo));
    }

    return ResponsiveCenter(
      child: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 75,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (states.updatedforeignWord.isEmpty ||
                        states.updatedforeignWord
                                .compareTo(widget.foreignWord) ==
                            0) &&
                    (listEquals(states.updatedWordMeans, List.filled(6, '')) ||
                        listEquals(cleanList(states.updatedWordMeans),
                            widget.means)) &&
                    (listEquals(
                            states.updatedWordExample, List.filled(6, '')) ||
                        listEquals(cleanList(states.updatedWordExample),
                            widget.examples)) &&
                    (states.updatedWordImages.isEmpty ||
                        listEquals(cleanList(states.updatedWordImages),
                            widget.imageList)) &&
                    ((states.updatedWordNote.isEmpty && widget.note.isEmpty) ||
                        states.updatedWordNote.compareTo(widget.note) == 0)
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('save changes'),
                            content:
                                const Text('Are you sure to save the changes'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Save'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
            icon: Icon(
              Icons.save_alt,
              color: primaryFontColor,
              size: 30,
            ),
          ),
        ],
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                if ((states.updatedforeignWord.isEmpty ||
                        states.updatedforeignWord
                                .compareTo(widget.foreignWord) ==
                            0) &&
                    (listEquals(states.updatedWordMeans, List.filled(6, '')) ||
                        listEquals(cleanList(states.updatedWordMeans),
                            widget.means)) &&
                    (listEquals(
                            states.updatedWordExample, List.filled(6, '')) ||
                        listEquals(cleanList(states.updatedWordExample),
                            widget.examples)) &&
                    (states.updatedWordImages.isEmpty ||
                        listEquals(cleanList(states.updatedWordImages),
                            widget.imageList)) &&
                    ((states.updatedWordNote.isEmpty && widget.note.isEmpty) ||
                        states.updatedWordNote.compareTo(widget.note) == 0)) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('save changes'),
                          content:
                              const Text('The changes you made wont be saved\n'
                                  'if you leaved without saving'),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Leave anyway'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.pop();
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Save'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  context.pop();
                }
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: primaryFontColor,
                size: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: Text(
                    'word Edit',
                    style: headline1Bold(primaryFontColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
