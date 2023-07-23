// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
// import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
// import 'package:mocktail/mocktail.dart';

// class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

// void main() {
//   group('the logo of the day group', () {
//     test('mon', () {
//       final logo = setDayLogo(1);
//       expect(logo.dayName, 'Mon');
//       expect(logo.dayColor, Colors.red[400]);
//       expect(logo.dayIcon, Icons.coffee_rounded);
//     });
//     test('Tue', () {
//       final logo = setDayLogo(2);
//       expect(logo.dayName, 'Tue');
//       expect(logo.dayColor, Colors.brown[300]);
//       expect(logo.dayIcon, Icons.sports_basketball_rounded);
//     });
//     test('Web', () {
//       final logo = setDayLogo(3);
//       expect(logo.dayName, 'Web');
//       expect(logo.dayColor, Colors.purple[400]);
//       expect(logo.dayIcon, Icons.local_movies_rounded);
//     });
//     test('Thu', () {
//       final logo = setDayLogo(4);
//       expect(logo.dayName, 'Thu');
//       expect(logo.dayColor, Colors.green[400]);
//       expect(logo.dayIcon, Icons.music_note_rounded);
//     });
//     test('Fri', () {
//       final logo = setDayLogo(5);
//       expect(logo.dayName, 'Fri');
//       expect(logo.dayColor, Colors.blue[400]);
//       expect(logo.dayIcon, Icons.sports_baseball_rounded);
//     });
//     test('Sat', () {
//       final logo = setDayLogo(6);
//       expect(logo.dayName, 'Sat');
//       expect(logo.dayColor, Colors.indigo[400]);
//       expect(logo.dayIcon, Icons.airplanemode_active_rounded);
//     });
//     test('Sun', () {
//       final logo = setDayLogo(7);
//       expect(logo.dayName, 'Sun');
//       expect(logo.dayColor, Colors.amber[600]);
//       expect(logo.dayIcon, Icons.wb_sunny_rounded);
//     });
//     test('none', () {
//       final logo = setDayLogo(0);
//       expect(logo.dayName, '-');
//       expect(logo.dayColor, Colors.red[400]);
//       expect(logo.dayIcon, Icons.coffee_rounded);
//     });
//   });

//   test('Day Logo helper function', () {
//     expect(DayLogo(Colors.red[400]!, Icons.coffee_rounded, 'Mon').toString(),
//         'DayLogo(dayColor: ${Colors.red[400]}, dayIcon: ${Icons.coffee_rounded}, dayName: Mon)');
//   });
//   test('groups Controller Provider return stream of list of group', () async {
//     final db = MockDriftGroupRepository();
//     final groupList = [
//       GroupData(id: 1, groupName: 'test1', creatingTime: DateTime.now()),
//       GroupData(id: 2, groupName: 'test2', creatingTime: DateTime.now())
//     ];
//     when(db.watchGroups).thenAnswer((_) => Stream.value(groupList));
//     final container = ProviderContainer(
//       overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
//     );
//     // The first read if the loading state
//     expect(
//       container.read(groupsControllerProvider),
//       const AsyncValue<List<GroupData>>.loading(),
//     );

//     /// Wait for the request to finish
//     await container.read(groupsControllerProvider.future);
//     expect(container.read(groupsControllerProvider).value, groupList);
//     verify(db.watchGroups).called(1);
//   });

//   test('watch Words List by Id Provider return stream of list of group',
//       () async {
//     final db = MockDriftGroupRepository();
//     final wordList = [
//       WordData(
//           id: 1,
//           group: 1,
//           foreignWord: 'test',
//           wordMeans: 'test-test',
//           wordImages: '',
//           wordExamples: 'etest-etest',
//           wordNote: '',
//           wordDate: DateTime.now()),
//       WordData(
//           id: 2,
//           group: 1,
//           foreignWord: 'test2',
//           wordMeans: 'test2-test2',
//           wordImages: '',
//           wordExamples: 'etest2-etest2',
//           wordNote: '',
//           wordDate: DateTime.now()),
//       WordData(
//           id: 3,
//           group: 1,
//           foreignWord: 'test3',
//           wordMeans: 'test3-test3',
//           wordImages: '',
//           wordExamples: 'etest3-etest3',
//           wordNote: '',
//           wordDate: DateTime.now()),
//     ];
//     when(() => db.watchWordsByGroupId(1))
//         .thenAnswer((_) => Stream.value(wordList));

//     final container = ProviderContainer(
//       overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
//     );
//     // The first read if the loading state
//     expect(
//       container.read(watchWordsListbyIdProvider(1)),
//       const AsyncValue<List<WordData>>.loading(),
//     );

//     /// Wait for the request to finish
//     await container.read(watchWordsListbyIdProvider(1).future);
//     expect(container.read(watchWordsListbyIdProvider(1)).value, wordList);
//     verify(() => db.watchWordsByGroupId(1)).called(1);
//   });
// }
