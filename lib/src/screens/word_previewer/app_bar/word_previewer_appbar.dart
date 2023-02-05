import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:go_router/go_router.dart';

class WordPreviewerAppBar extends StatelessWidget with PreferredSizeWidget {
  const WordPreviewerAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 75,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Consumer(
              builder: (context, ref, child) => IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: primaryFontColor,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: Text(
                    'word view',
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
