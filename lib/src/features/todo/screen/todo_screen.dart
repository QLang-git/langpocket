import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/todo/appbar/todo_appbar.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';
import 'package:langpocket/src/features/todo/widgets/todo_today.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData(
      :colorScheme,
    ) = Theme.of(context);
    return DefaultTabController(
        length: 2,
        child: ResponsiveCenter(
          child: Scaffold(
            backgroundColor: colorScheme.background,
            appBar: const TodoAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              child: Consumer(
                builder: (context, ref, child) {
                  final todosValue = ref.watch(todoControllerProvider);

                  return AsyncValueWidget(
                      value: todosValue,
                      child: (todos) {
                        final forToday = <TodoContents>[];
                        final forOtherDay = <TodoContents>[];

                        for (var todo in todos) {
                          if (todo.isToday) {
                            forToday.add(todo);
                          } else {
                            forOtherDay.add(todo);
                          }
                        }
                        return TabBarView(children: [
                          TodoToday(
                            todoContents: forToday,
                          ),
                          Text(forOtherDay.length.toString())
                        ]);
                      });
                },
              ),
            ),
          ),
        ));
  }
}
