import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';
import 'package:langpocket/src/features/todo/widgets/daily_item.dart';

class TodoToday extends StatefulWidget {
  final List<TodoContents> todoContents;
  const TodoToday({super.key, required this.todoContents});

  @override
  State<TodoToday> createState() => _TodoTodayState();
}

class _TodoTodayState extends State<TodoToday> {
  @override
  Widget build(BuildContext context) {
    final ThemeData(:textTheme) = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 5),
          child: Text(
            '- Your Todo List for Today',
            style: textTheme.displayLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.todoContents.length,
              itemBuilder: (context, index) {
                final todo = widget.todoContents[index];
                if (todo.groupData == null) {
                  return DailyItem(isChecked: todo.isChecked);
                }
                final GroupData(:id, :groupName, :creatingTime) =
                    todo.groupData!;

                final DateTime(:day, :month, :year) = creatingTime;
                return TodoItem(
                    isChecked: todo.isChecked,
                    groupName: groupName,
                    day: day,
                    month: month,
                    year: year,
                    id: id);
              }),
        ),
      ],
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.isChecked,
    required this.groupName,
    required this.day,
    required this.month,
    required this.year,
    required this.id,
  });

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      // Default style for the whole text
                      style: textTheme.displayMedium!.copyWith(
                          color: colorScheme.outline,
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
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                          .checkController(id.toString());
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
