import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class SpellingAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SpellingAppBar({super.key});

  @override
  State<SpellingAppBar> createState() => _SpellingAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(80);
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
