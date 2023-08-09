import 'package:flutter/material.dart';
import 'package:langpocket/src/features/todo/appbar/todo_appbar.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const TodoAppBar(),
      body: Column(
        children: [
          Card(
            color: Colors.blue,
              margin: const EdgeInsets.all(30),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  '',
                  style: textTheme.headlineMedium
                      ?.copyWith(color: colorScheme.outline),
                ),
              ))
        ],
      ),
    );
  }
}
