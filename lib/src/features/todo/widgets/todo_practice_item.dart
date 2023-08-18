import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    this.activateCheckBox = true,
    required this.isChecked,
    required this.groupName,
    required this.day,
    required this.month,
    required this.year,
    required this.id,
    required this.isLate,
    this.studyAt,
  });

  final bool activateCheckBox;
  final DateTime? studyAt;
  final bool isLate;
  final bool isChecked;
  final String groupName;
  final int day;
  final int month;
  final int year;
  final int id;

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
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        // Default style for the whole text

                        style: textTheme.displayMedium!.copyWith(
                            color: colorScheme.outline,
                            overflow: TextOverflow.ellipsis,
                            decorationThickness: 2.0,
                            decoration:
                                isChecked ? TextDecoration.lineThrough : null),
                        children: [
                          TextSpan(
                            text: 'Practice time: ',
                            style: textTheme.labelLarge!.copyWith(
                                color: colorScheme.outline,
                                decorationThickness: 2.0,
                                decoration: isChecked
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          TextSpan(
                            text: groupName,

                            // Different style for this part (you can leave it as the default style or customize it)
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    RichText(
                        text: TextSpan(
                      // Default style for the whole text
                      style: textTheme.labelSmall!.copyWith(
                          color: colorScheme.outline,
                          decorationThickness: 2.0,
                          decoration:
                              isChecked ? TextDecoration.lineThrough : null),
                      children: [
                        TextSpan(
                          text: 'You Created at: ',
                          style: textTheme.headlineSmall!.copyWith(
                              color: colorScheme.outline,
                              decorationThickness: 2.0,
                              decoration: isChecked
                                  ? TextDecoration.lineThrough
                                  : null), // Different style for this part
                        ),
                        TextSpan(
                          text: '$day/$month/$year',

                          // Different style for this part (you can leave it as the default style or customize it)
                        ),
                      ],
                    )),
                    const SizedBox(height: 5),
                    studyAt != null && !isLate
                        ? Container(
                            padding: const EdgeInsets.all(3),
                            color: colorScheme.primary,
                            child: RichText(
                                text: TextSpan(
                              // Default style for the whole text
                              style: textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                  decorationThickness: 2.0,
                                  decoration: isChecked
                                      ? TextDecoration.lineThrough
                                      : null),
                              children: [
                                TextSpan(
                                  text: 'Study this at: ',
                                  style: textTheme.labelLarge!.copyWith(
                                      color: Colors.white,
                                      decorationThickness: 2.0,
                                      decoration: isChecked
                                          ? TextDecoration.lineThrough
                                          : null), // Different style for this part
                                ),
                                TextSpan(
                                  text:
                                      '${studyAt!.day}/${studyAt!.month}/${studyAt!.year}',

                                  // Different style for this part (you can leave it as the default style or customize it)
                                ),
                              ],
                            )),
                          )
                        : studyAt != null && isLate
                            ? Container(
                                padding: const EdgeInsets.all(3),
                                color: colorScheme.error,
                                child: RichText(
                                    text: TextSpan(
                                  // Default style for the whole text
                                  style: textTheme.labelMedium!.copyWith(
                                      color: Colors.white,
                                      decorationThickness: 2.0,
                                      decoration: isChecked
                                          ? TextDecoration.lineThrough
                                          : null),
                                  children: [
                                    TextSpan(
                                      text: 'Missed On:',
                                      style: textTheme.labelLarge!.copyWith(
                                          color: Colors.white,
                                          decorationThickness: 2.0,
                                          decoration: isChecked
                                              ? TextDecoration.lineThrough
                                              : null), // Different style for this part
                                    ),
                                    TextSpan(
                                      text:
                                          '${studyAt!.day}/${studyAt!.month}/${studyAt!.year}',

                                      // Different style for this part (you can leave it as the default style or customize it)
                                    ),
                                  ],
                                )),
                              )
                            : Container(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  scale:
                      1.3, // adjust the scale to make the checkbox larger or smaller
                  child: Consumer(
                    builder: (context, ref, child) => Checkbox(
                      activeColor: colorScheme.primary,
                      value: isChecked,
                      onChanged: activateCheckBox
                          ? (status) async {
                              await ref
                                  .read(todoControllerProvider.notifier)
                                  .checkController(id.toString());
                            }
                          : null,
                    ),
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
