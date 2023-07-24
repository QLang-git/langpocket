import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class MeanWord extends ConsumerStatefulWidget {
  const MeanWord({Key? key}) : super(key: key);

  @override
  ConsumerState<MeanWord> createState() => _MeanWordState();
}

class _MeanWordState extends ConsumerState<MeanWord> {
  final meaningControllers = [TextEditingController()];

  void addMeaning() {
    meaningControllers.add(TextEditingController());
  }

  void removeMeaning(int index) {
    meaningControllers[index].clear();
    ref.read(newWordControllerProvider.notifier).saveWordMeans('', index);
    meaningControllers.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (int i = 0; i < meaningControllers.length; i++)
        MeaningInputField(
          controller: meaningControllers[i],
          index: i,
          removeMeaning: removeMeaning,
        ),
      if (meaningControllers.length < 3)
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: const CircleBorder(),
          ),
          onPressed: addMeaning,
          child: const Icon(
            Icons.add,
            size: 45,
            color: Colors.white,
          ),
        ),
    ]);
  }

  @override
  void dispose() {
    for (var controller in meaningControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class MeaningInputField extends ConsumerWidget {
  final TextEditingController controller;
  final int index;
  final Function(int) removeMeaning;

  const MeaningInputField({
    super.key,
    required this.controller,
    required this.index,
    required this.removeMeaning,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 2),
      child: Consumer(builder: (context, watch, _) {
        final newWordController = ref.read(newWordControllerProvider.notifier);

        return TextFormField(
          controller: controller,
          style: headline3(primaryFontColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            suffixIcon: index > 0
                ? TextButton(
                    onPressed: () => removeMeaning(index),
                    child: Icon(
                      Icons.close_outlined,
                      color: primaryColor,
                    ),
                  )
                : Icon(
                    Icons.language_outlined,
                    color: primaryColor,
                  ),
            labelStyle: bodyLarge(primaryColor),
            label: const Text('Mean'),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: secondaryColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          validator: (value) {
            if (value == null || (index == 0 && value.isEmpty)) {
              return 'Please enter one meaning for this word';
            } else {
              newWordController.saveWordMeans(value, index);
            }
            return null;
          },
        );
      }),
    );
  }
}
