import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_controller.dart';

class SpellingAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SpellingController spellingController;
  const SpellingAppBar({super.key, required this.spellingController});

  @override
  State<SpellingAppBar> createState() => _SpellingAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SpellingAppBarState extends State<SpellingAppBar> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return ResponsiveCenter(
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 37),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, left: 15),
              child: IconButton(
                  onPressed: () => widget.spellingController.startOver(),
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 35,
                    color: Colors.white,
                  )))
        ],
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Pr. Spelling',
            style: textStyle.headlineLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
