import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/custom_warning_dialog.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/word_edit/controller/word_editor_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class WordEditorAppbar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final WordRecord wordData;
  final EditWordController editWordController;
  final GlobalKey<FormState> formKey;
  const WordEditorAppbar({
    super.key,
    required this.editWordController,
    required this.formKey,
    required this.wordData,
  });

  @override
  ConsumerState<WordEditorAppbar> createState() => _WordEditorAppbarState();
  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class _WordEditorAppbarState extends ConsumerState<WordEditorAppbar> {
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
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        title: Text(
          widget.wordData.foreignWord,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          AsyncValueWidget(
            value: ref.watch(newWordControllerProvider),
            child: (newWord) {
              return Padding(
                padding: const EdgeInsets.only(right: 6.5),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomWarningDialog(
                              onCancel: () {},
                              title: const Text('save changes'),
                              cancelOption: const Text('Cancel'),
                              message: const Text(
                                  'Are you sure to save the changes'),
                              onSave: () => widget.editWordController
                                      .updateWordInfo(newWord.copyWith(
                                          id: widget.wordData.id))
                                      .then((status) {
                                    if (status) {
                                      context.pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'The word has been updated')),
                                      );
                                    }
                                  }));
                        });
                  },
                  icon: const Icon(
                    Icons.save_alt,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            },
          )
        ],
        leading: AsyncValueWidget(
          value: ref.watch(newWordControllerProvider),
          child: (word) {
            return Padding(
              padding: const EdgeInsets.only(left: 4),
              child: IconButton(
                onPressed: () {
                  if (widget.editWordController.isWordInfoSimilar(
                      word.copyWith(id: widget.wordData.id))) {
                    context.pop();
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer(
                            builder: (context, ref, child) =>
                                CustomWarningDialog(
                                    onCancel: () => context.pop(),
                                    cancelOption: const Text('Leave anyway'),
                                    title: const Text('save changes'),
                                    message: const Text(
                                        'The changes you made wont be saved\n'
                                        'if you leaved without saving'),
                                    onSave: () {}),
                          );
                        });
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
