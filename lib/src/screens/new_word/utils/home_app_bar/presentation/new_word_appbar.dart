import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NewWordAppBar extends StatefulWidget with PreferredSizeWidget {
  const NewWordAppBar({super.key});

  @override
  State<NewWordAppBar> createState() => _NewWordAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NewWordAppBarState extends State<NewWordAppBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 15),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.preview_outlined,
                  size: 35,
                  color: primaryFontColor,
                )),
          )
        ],
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'List Name',
            style: headline1Bold(primaryFontColor),
          ),
        ),
      ),
    );
  }
}
