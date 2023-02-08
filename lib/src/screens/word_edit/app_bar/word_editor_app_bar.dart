import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
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
            onPressed: (states.updatedforeignWord.isNotEmpty &&
                        states.updatedforeignWord != widget.foreignWord) ||
                    (states.updatedWordMeans.isNotEmpty &&
                        !listEquals(states.updatedWordMeans, widget.means)) ||
                    (states.updatedWordExample.isNotEmpty &&
                        !listEquals(
                            states.updatedWordExample, widget.examples)) ||
                    (states.updatedWordImages.isNotEmpty &&
                        !listEquals(
                            states.updatedWordImages, widget.imageList)) ||
                    (states.updatedWordNote.isNotEmpty &&
                        states.updatedWordNote != widget.note)
                ? () {
                    print('you change something');
                  }
                : null,
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
                context.pop();
                //todo: show message if user want to save the update or not
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
