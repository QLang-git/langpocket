import 'package:flutter/material.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';
import 'package:langpocket/src/features/todo/widgets/daily_item.dart';
import 'package:langpocket/src/features/todo/widgets/todo_practice_item.dart';

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
                    isLate: todo.isLate,
                    studyAt: todo.groupData?.studyTime,
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
