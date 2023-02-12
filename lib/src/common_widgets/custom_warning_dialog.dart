import 'package:flutter/material.dart';

class CustomWarningDialog extends StatelessWidget {
  final Widget title;
  final Widget message;
  final Widget cancelOption;
  final Function() onSave;
  final Function() onCancel;

  const CustomWarningDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onSave,
    required this.cancelOption,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: message,
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: cancelOption,
          onPressed: () {
            Navigator.of(context).pop();
            onCancel();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Save'),
          onPressed: () {
            onSave();

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
