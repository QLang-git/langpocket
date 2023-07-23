import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/new_word/controller/save_word_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class ExampleWord extends ConsumerStatefulWidget {
  const ExampleWord({Key? key}) : super(key: key);

  @override
  ConsumerState<ExampleWord> createState() => _ExampleWordState();
}

class _ExampleWordState extends ConsumerState<ExampleWord> {
  final exampleControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  void dispose() {
    for (var controller in exampleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addExample() {
    exampleControllers.add(TextEditingController());
  }

  void removeExample(int index) {
    exampleControllers[index].clear();
    ref.read(newWordControllerProvider.notifier).saveWordExample('', index);
    exampleControllers.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
          child: Text(
            'Add examples',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      for (int i = 0; i < exampleControllers.length; i++)
        ExampleInputField(
          controller: exampleControllers[i],
          index: i,
          removeExample: removeExample,
        ),
      if (exampleControllers.length < 5)
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: const CircleBorder(),
          ),
          onPressed: addExample,
          child: const Icon(
            Icons.add,
            size: 45,
            color: Colors.white,
          ),
        ),
    ]);
  }
}

class ExampleInputField extends ConsumerWidget {
  final TextEditingController controller;
  final int index;
  final Function(int) removeExample;

  const ExampleInputField({
    super.key,
    required this.controller,
    required this.index,
    required this.removeExample,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Consumer(builder: (context, watch, _) {
        final newWordController = ref.read(newWordControllerProvider.notifier);

        return TextFormField(
          controller: controller,
          style: headline3(primaryFontColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            suffixIcon: index > 1
                ? TextButton(
                    onPressed: () => removeExample(index),
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
            label: Text('example ${index + 1}'),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: secondaryColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          validator: (value) {
            if (value == null || (index < 2 && value.isEmpty)) {
              return 'Please enter 2 examples for this word';
            } else {
              newWordController.saveWordExample(value, index);
            }
            return null;
          },
        );
      }),
    );
  }
}
