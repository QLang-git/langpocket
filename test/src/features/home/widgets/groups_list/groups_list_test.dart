import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/features/home/widgets/groups_list/groups_list.dart';
import 'package:mocktail/mocktail.dart';

import '../../screen/home_robot.dart';

class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

void main() {
  late List<GroupData> groups;
  late List<WordData> words;
  setUp(() {
    groups = [
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
    words = [
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
        wordExamples: 'this is new',
        wordImages: '',
        wordNote: '',
        wordDate: DateTime(2023, 1, 30),
      )
    ];
  });
  group('existing', () {
    testWidgets('show not found message if no group in DB', (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value([]));

      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        r.noGroupInDb();
      });
    });
    testWidgets('show the groups in  DB', (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value(groups));
      when(() => db.watchWordsByGroupId(1))
          .thenAnswer((_) => Stream.value([words.first]));
      when(() => db.watchWordsByGroupId(2))
          .thenAnswer((_) => Stream.value([words.last]));
      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        r.runderGroups(groups);
      });
    });
    testWidgets('show the words in existing groups', (tester) async {
      //set up
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value(groups));
      when(() => db.watchWordsByGroupId(1))
          .thenAnswer((_) => Stream.value([words.first]));
      when(() => db.watchWordsByGroupId(2))
          .thenAnswer((_) => Stream.value([words.last]));

      await tester.runAsync(() async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: MyWordsInGroup(words: words),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('word1 , '), findsOneWidget);
        expect(find.text('word2 '), findsOneWidget);
      });
    });
  });
  group('Actions', () {
    testWidgets('nav to words list for the group that been clicked',
        (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value(groups));
      when(() => db.watchWordsByGroupId(1))
          .thenAnswer((_) => Stream.value([words.first]));
      when(() => db.watchWordsByGroupId(2))
          .thenAnswer((_) => Stream.value([words.last]));

      // testing
      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        // expect(find.byType(MyWordsInGroup), findsWidgets);
        await r.navToGroupScreenByGivingId(1);
      });
    });
  });
}
