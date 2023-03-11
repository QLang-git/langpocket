import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class HomeRobot {
  final WidgetTester tester;
  HomeRobot(this.tester);
  Future<void> pumpHomeScreen() async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: goroute,
          ),
        ),
      );
    });
  }

  void hasIconNewWord() {
    final icon = find.byIcon(Icons.add);
    expect(icon, findsOneWidget);
  }

  void hasGroupTitle() {
    final title = find.text('Groups');
    expect(title, findsOneWidget);
  }

  void hasTodoButton() async {
    final btn = find.text('Todo');

    expect(btn, findsWidgets);
  }

  // void noGroupInDb() async {
  //   final message = find.text('You don\'t have any group yet');
  //   expect(message, findsOneWidget);
  // }

  Future<void> navToAddNewWord() async {
    final icon = find.byIcon(Icons.add);
    expect(icon, findsWidgets);
    await tester.tap(icon);
    await tester.pumpAndSettle();
    final newWordScreen = find.byType(NewWordScreen);

    expect(newWordScreen, findsOneWidget);
  }
}
