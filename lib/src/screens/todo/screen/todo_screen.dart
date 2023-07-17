import 'package:flutter/material.dart';
import 'package:langpocket/src/screens/todo/appbar/todo_appbar.dart';

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
              margin: const EdgeInsets.all(30),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'This feature is currently under development and is not part of our beta version.\nIts purpose is to provide you with helpful reminders and guidance on the next steps to take towards achieving your language learning goals.\nWhether it\'s adding new words to your vocabulary, practicing listening skills with yesterday\'s words, or engaging in spelling practice, this feature will assist you by sending notifications directly to you.\nThese notifications will serve as reminders for the tasks and activities you have lined up, acting as your personal language learning assistant.',
                  style: textTheme.headlineMedium
                      ?.copyWith(color: colorScheme.outline),
                ),
              ))
        ],
      ),
    );
  }
}
