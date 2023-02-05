import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class NewWordAppBar extends StatefulWidget with PreferredSizeWidget {
  final GlobalKey<FormState> formKey;

  const NewWordAppBar({super.key, required this.formKey});

  @override
  State<NewWordAppBar> createState() => _NewWordAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NewWordAppBarState extends State<NewWordAppBar> {
  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<NewWordScreenState>()!;
    return ResponsiveCenter(
      child: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, left: 15),
              child: IconButton(
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      context.goNamed(
                        AppRoute.wordView.name,
                        extra: WordDataToView(
                            foreignWord: states.foreignWord,
                            wordMeans: states.wordMeans,
                            wordImages: states.wordImages,
                            wordExamples: states.wordExample,
                            wordNote: states.wordNote),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.preview_outlined,
                    size: 35,
                    color: primaryFontColor,
                  )))
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
