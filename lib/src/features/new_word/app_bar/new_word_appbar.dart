import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class NewWordAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<FormState> formKey;

  const NewWordAppBar({super.key, required this.formKey});

  @override
  State<NewWordAppBar> createState() => _NewWordAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class _NewWordAppBarState extends State<NewWordAppBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 37),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.5),
            child: IconButton(
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    // context.goNamed(
                    //   AppRoute.wordView.name,
                    //   extra: WordRecord(
                    //       foreignWord: states.foreignWord,
                    //       wordMeans: states.wordMeans,
                    //       wordImages: states.wordImages,
                    //       wordExamples: states.wordExample,
                    //       wordNote: states.wordNote),
                    // );
                  }
                },
                icon: const Icon(
                  Icons.preview_outlined,
                )),
          )
        ],
        centerTitle: true,
        title: Text(
          'New word',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
