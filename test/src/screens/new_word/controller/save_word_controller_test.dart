import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/screens/new_word/controller/save_word_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

class FackGroupCompanion extends Fake implements GroupCompanion {}

class FackWordCompanion extends Fake implements WordCompanion {}

void main() {
  late MockDriftGroupRepository db;

  setUp(() {
    db = MockDriftGroupRepository();
    registerFallbackValue(FackGroupCompanion());
    registerFallbackValue(FackWordCompanion());
  });

  group('save word', () {
    test('save word controller with valid info in new (group new day)',
        () async {
      final container = ProviderContainer(
        overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
      );
      when(() => db.fetchGroupByTime(any<DateTime>())).thenThrow(Exception());
      when(() => db.createGroup(any<GroupCompanion>()))
          .thenAnswer((_) => Future.value(
                GroupData(
                  id: 1,
                  groupName: 'g',
                  creatingTime: DateTime.now(),
                ),
              ));
      final controller = container.read(saveWordControllerProvider.notifier);
      when(() => db.addNewWordInGroup(any<WordCompanion>()))
          .thenAnswer((_) => Future.value());
      await controller.addNewWord(
          foreignWord: 'myTest',
          wordMeans: 'test-test',
          wordImages: '',
          wordExamples: 'etest1-etest2',
          wordNote: '');

      verify(() => db.fetchGroupByTime(any<DateTime>())).called(1);
      verify(() => db.createGroup(any<GroupCompanion>())).called(1);
      verify(() => db.addNewWordInGroup(any<WordCompanion>())).called(1);
      expect(controller.debugState.hasError, false);
    });
    test('save word with valid info in existing group', () async {
      final container = ProviderContainer(
        overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
      );
      when(() => db.fetchGroupByTime(any<DateTime>()))
          .thenAnswer((_) => Future.value(
                GroupData(
                  id: 1,
                  groupName: 'g',
                  creatingTime: DateTime.now(),
                ),
              ));
      final controller = container.read(saveWordControllerProvider.notifier);
      when(() => db.addNewWordInGroup(any<WordCompanion>()))
          .thenAnswer((_) => Future.value());
      await controller.addNewWord(
          foreignWord: 'myTest',
          wordMeans: 'test-test',
          wordImages: '',
          wordExamples: 'etest1-etest2',
          wordNote: '');

      verify(() => db.fetchGroupByTime(any<DateTime>())).called(1);
      verifyNever(() => db.createGroup(any<GroupCompanion>()));
      verify(() => db.addNewWordInGroup(any<WordCompanion>())).called(1);
      expect(controller.debugState.hasError, false);
    });
  });
  test('save word controller with invalid info', () async {
    final container = ProviderContainer(
      overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
    );

    final controller = container.read(saveWordControllerProvider.notifier);

    await controller.addNewWord(
        foreignWord: '',
        wordMeans: 'test-test',
        wordImages: '',
        wordExamples: 'etest1-etest2',
        wordNote: '');

    verifyNever(() => db.fetchGroupByTime(any<DateTime>()));
    verifyNever(() => db.createGroup(any<GroupCompanion>()));
    verifyNever(() => db.addNewWordInGroup(any<WordCompanion>()));
    expect(controller.debugState.hasError, true);
  });

  test('save word with invalid info , server error', () async {
    final container = ProviderContainer(
      overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
    );
    when(() => db.fetchGroupByTime(any<DateTime>()))
        .thenAnswer((_) => Future.value(
              GroupData(
                id: 1,
                groupName: 'g',
                creatingTime: DateTime.now(),
              ),
            ));
    final controller = container.read(saveWordControllerProvider.notifier);
    await controller.addNewWord(
        foreignWord: 'myTest',
        wordMeans: 'test-test',
        wordImages: '',
        wordExamples: 'etest1-etest2',
        wordNote: '');

    verify(() => db.fetchGroupByTime(any<DateTime>())).called(1);
    verifyNever(() => db.createGroup(any<GroupCompanion>()));
    verify(() => db.addNewWordInGroup(any<WordCompanion>())).called(1);
    expect(controller.debugState.hasError, true);
  });
}
