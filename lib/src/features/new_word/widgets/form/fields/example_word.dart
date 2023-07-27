import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/new_word/controller/validation_input.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class ExampleWord extends ConsumerStatefulWidget {
  final List<String>? examples;
  const ExampleWord({Key? key, this.examples}) : super(key: key);

  @override
  ConsumerState<ExampleWord> createState() => _ExampleWordState();
}

class _ExampleWordState extends ConsumerState<ExampleWord> {
  var exampleControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    if (widget.examples != null) {
      exampleControllers = [];
      int index = 0;
      widget.examples?.map((example) {
        exampleControllers.add(TextEditingController(text: example));
        Future.delayed(Duration.zero, () {
          ref
              .read(newWordControllerProvider.notifier)
              .saveWordExample(example, index);
          index += 1;
        });
      }).toList();
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in exampleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addExample() {
    setState(() {
      exampleControllers.add(TextEditingController());
    });
  }

  void removeExample(int index) {
    ref.read(newWordControllerProvider.notifier).saveWordExample('', index);
    setState(() {
      exampleControllers[index].clear();
      exampleControllers.removeAt(index);
    });
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
          isUpdating: widget.examples != null,
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
  final bool isUpdating;
  final TextEditingController controller;
  final int index;
  final Function(int) removeExample;

  const ExampleInputField({
    super.key,
    required this.isUpdating,
    required this.controller,
    required this.index,
    required this.removeExample,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validate = ValidationInput();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Consumer(builder: (context, watch, _) {
        final newWordController = ref.read(newWordControllerProvider.notifier);

        return TextFormField(
          key: Key('ExampleWord$index'),
          onChanged: (value) {
            if (isUpdating) {
              newWordController.saveWordExample(value, index);
            }
          },
          controller: controller,
          style: headline3(primaryFontColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            suffixIcon: index > 1
                ? TextButton(
                    onPressed: () {
                      removeExample(index);
                    },
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
            final (:status, :message) =
                validate.exampleWordsValidation([value ?? '']);
            if (!status) {
              return message;
            } else {
              newWordController.saveWordExample(value!, index);
            }
            return null;
          },
        );
      }),
    );
  }
}
