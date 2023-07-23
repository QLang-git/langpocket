import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class PracticeInteractiveAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const PracticeInteractiveAppBar({super.key});

  @override
  State<PracticeInteractiveAppBar> createState() =>
      _PracticeInteractiveAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _PracticeInteractiveAppBarState extends State<PracticeInteractiveAppBar> {
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 35,
                    color: Colors.white,
                  )))
        ],
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Interactively',
            style: textStyle.headlineLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
