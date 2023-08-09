import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';

class DailyItem extends StatelessWidget {
  const DailyItem({
    super.key,
    required this.isChecked,
  });

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add new word Today!',
                    maxLines: 1,
                    style: textTheme.displayLarge!.copyWith(
                        color: colorScheme.outline,
                        decorationThickness: 2.0,
                        decoration:
                            isChecked ? TextDecoration.lineThrough : null),
                  ),
                  Text(
                    'Embrace new expressions\nYour language adventure starts here!',
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: textTheme.headlineSmall!.copyWith(
                        color: colorScheme.outline,
                        decorationThickness: 2.0,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : null), // Different style for this part
                  ),
                ],
              ),
              Transform.scale(
                scale:
                    1.3, // adjust the scale to make the checkbox larger or smaller
                child: Consumer(
                  builder: (context, ref, child) => Checkbox(
                    activeColor: colorScheme.primary,
                    value: isChecked,
                    onChanged: (status) {
                      ref
                          .read(todoControllerProvider.notifier)
                          .checkController('x');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
