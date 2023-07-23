import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/features/word_view/screen/word_view_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../home/screen/home_robot.dart';

class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

final groups = [
  GroupData(
    id: 1,
    groupName: 'first',
    creatingTime: DateTime.now(),
  ),
  GroupData(
    id: 2,
    groupName: 'second',
    creatingTime: DateTime(2023, 1, 30),
  )
];
final words = [
  WordData(
      id: 1,
      group: 1,
      foreignWord: 'word1',
      wordMeans: 'mean1-mean2',
      wordExamples: 'this is new',
      wordImages: '',
      wordNote: '',
      wordDate: DateTime.now()),
  WordData(
    id: 2,
    group: 2,
    foreignWord: 'word2',
    wordMeans: 'mean1-mean2',
    wordExamples: 'this is new2',
    wordImages: '',
    wordNote: '',
    wordDate: DateTime(2023, 1, 30),
  )
];

class GroupRobot {
  final WidgetTester tester;
  final int groupId;
  GroupRobot(this.tester, this.groupId);
  final db = MockDriftGroupRepository();
  Future<void> pumpGroupScreen() async {
    final r = HomeRobot(tester);
    when(db.watchGroups).thenAnswer((_) => Stream.value(groups));
    when(() => db.watchWordsByGroupId(1))
        .thenAnswer((_) => Stream.value([words.first]));
    when(() => db.watchWordsByGroupId(2))
        .thenAnswer((_) => Stream.value([words.last]));

    await r.pumpHomeScreen(db);
    await tester.pumpAndSettle();
    await r.navToGroupScreenByGivingId(groupId);
  }

  void hasGroupNameAndData() {
    final group = groups[groupId - 1];
    final name = find.text(group.groupName);
    final date = find.text(
        '${group.creatingTime.day}/${group.creatingTime.month}/${group.creatingTime.year}');
    expect(name, findsOneWidget);
    expect(date, findsOneWidget);
  }

  void hasOnleyRelatedWord() {
    final wordIn = words.where((word) => word.group == groupId).toList();
    final wordNot = words.where((word) => word.group != groupId).toList();
    for (var word in wordIn) {
      expect(find.text(word.foreignWord), findsOneWidget);
      expect(find.text(word.meansList().first), findsNothing);
      expect(find.text(word.examplesList().first), findsOneWidget);
    }
    for (var word in wordNot) {
      expect(find.text(word.foreignWord), findsNothing);
      expect(find.text(word.meansList().first), findsNothing);
      expect(find.text(word.examplesList().first), findsNothing);
    }
  }

  Future<void> navToWordScreen() async {
    final wordIn = words.where((word) => word.group == groupId).toList().first;

    final word = find.text(wordIn.foreignWord);
    await tester.tap(word);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    final groupscreen = find.byType(WordViewScreen);
    expect(groupscreen, findsOneWidget);
  }

  Future<void> removeWordFromScreen() async {
    final wordIn = words.where((word) => word.group == groupId).toList().first;

    final word = find.byKey(Key(wordIn.id.toString()));
    expect(word, findsOneWidget);

    await tester.drag(word, const Offset(-10, 0.0));

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(word, findsNothing);
    // expect(find.byType(SnackBar), findsOneWidget);

    // expect(find.byType(ScaffoldMessenger), findsNothing);
  }
}
