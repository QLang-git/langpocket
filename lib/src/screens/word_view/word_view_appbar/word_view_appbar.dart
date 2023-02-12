import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:go_router/go_router.dart';

class WordViewAppBar extends StatelessWidget with PreferredSizeWidget {
  final WordData wordData;
  const WordViewAppBar({
    super.key,
    required this.wordData,
  });
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13, top: 5),
            child: IconButton(
              onPressed: () {
                context.push(
                  '${GoRouter.of(context).location}/edit-mode',
                  extra: wordData,
                );
              },
              icon: Icon(
                Icons.edit_document,
                color: primaryFontColor,
                size: 30,
              ),
            ),
          ),
        ],
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                context.pop();
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
                    wordData.foreignWord,
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
