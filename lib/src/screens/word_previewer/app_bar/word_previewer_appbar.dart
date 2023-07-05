import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class WordPreviewerAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const WordPreviewerAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        leadingWidth: 65,
        iconTheme: const IconThemeData(color: Colors.white, size: 37),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        centerTitle: true,
        title: Text(
          'Word View',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
