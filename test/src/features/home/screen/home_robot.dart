import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/features/group/screen/group_screen.dart';
import 'package:langpocket/src/features/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class HomeRobot {
  final WidgetTester tester;
  HomeRobot(this.tester);
  Future<void> pumpHomeScreen([DriftGroupRepository? db]) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    if (db != null) {
      await tester.pumpWidget(ProviderScope(
        overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          routerConfig: goroute,
        ),
      ));
    } else {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: goroute,
          ),
        ),
      );
    }
    await tester.pump();
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

  void noGroupInDb() async {
    final messag = find.text('You don\'t have any group yet');
    expect(messag, findsOneWidget);
  }

  void runderGroups(List<GroupData> groupList) {
    for (var group in groupList) {
      expect(find.text(group.groupName), findsOneWidget);
      expect(
          find.text(
              'Date: ${group.creatingTime.day}/${group.creatingTime.month}/${group.creatingTime.year}'),
          findsOneWidget);
    }
  }

  Future<void> navToAddNewWord() async {
    final icon = find.byIcon(Icons.add);
    expect(icon, findsWidgets);
    await tester.tap(icon);
    await tester.pumpAndSettle();
    final newWordScreen = find.byType(NewWordScreen);
    expect(newWordScreen, findsOneWidget);
  }

  Future<void> navToGroupScreenByGivingId(int id) async {
    final firstGroup = find.byKey(Key('group-$id'));
    expect(firstGroup, findsOneWidget);
    await tester.tap(firstGroup);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    final groupscreen = find.byType(GroupScreen);
    expect(groupscreen, findsOneWidget);
  }
}
