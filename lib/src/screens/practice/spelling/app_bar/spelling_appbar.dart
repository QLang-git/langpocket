import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/practice/spelling/screen/practice_spelling_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class SpellingAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SpellingAppBar({super.key});

  @override
  State<SpellingAppBar> createState() => _SpellingAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SpellingAppBarState extends State<SpellingAppBar> {
  @override
  Widget build(BuildContext context) {
    final states =
        context.findAncestorStateOfType<PracticeSpellingScreenState>()!;

    return ResponsiveCenter(
      child: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, left: 15),
              child: IconButton(
                  onPressed: () => states.reloadPage(),
                  icon: Icon(
                    Icons.refresh_rounded,
                    size: 35,
                    color: primaryFontColor,
                  )))
        ],
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Practice Spelling',
            style: headline1Bold(primaryFontColor),
          ),
        ),
      ),
    );
  }
}
