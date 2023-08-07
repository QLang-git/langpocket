import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../screen/home_robot.dart';

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
        level: 0,
      ),
      GroupData(
          id: 2,
          groupName: 'second',
          creatingTime: DateTime(2023, 1, 30),
          level: 0)
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
  group('existing. Succeed', () {
    // You don\'t have any group yet
    testWidgets('show not found message if no group in DB', (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value([]));

      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        r.hasNoGroup();
      });
    });
    testWidgets('show the groups in  in home screen', (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value(groups));
      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        r.hasAllGroups(groups);
      });
    });
  });

  group('existing , Failed', () {
    testWidgets('Failed Loading the words from DB', (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenAnswer((_) => Stream.value(groups));
      when(() => db.watchWordsByGroupId(1))
          .thenThrow(Exception('Loading Error'));
      when(() => db.watchWordsByGroupId(2))
          .thenThrow(Exception('Loading Error'));
      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        r.failedLoadingWords('Failed Loading the words');
      });
    });
    testWidgets('Failed Loading the groups from DB', (tester) async {
      //set up
      final r = HomeRobot(tester);
      final db = MockDriftGroupRepository();
      when(db.watchGroups).thenThrow(Exception('Loading Error'));

      await tester.runAsync(() async {
        await r.pumpHomeScreen(db);
        await tester.pumpAndSettle();
        r.failedLoadingGroups('Exception: Loading Error');
      });
    });
  });

  group('Actions , Succeed', () {
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

  group('Action, Failed', () {
    //todo: implement action failed here
  });
}
