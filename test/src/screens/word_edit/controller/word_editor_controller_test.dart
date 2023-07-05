import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/screens/word_edit/controller/word_editor_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

void main() {
  test('update Word Info Provider ...', () async {
    final db = MockDriftGroupRepository();
    final newWord = WordCompanion.insert(
        group: 1,
        foreignWord: 'foreignWord',
        wordMeans: 'wordMeans',
        wordImages: 'wordImages',
        wordExamples: 'wordExamples',
        wordNote: 'wordNote',
        wordDate: DateTime.now());
    final newinfo = NewWordInfo(1, newWord);
    when(() => db.upadateWordInf(1, newWord)).thenAnswer((_) => Future.value());
    final container = ProviderContainer(
      overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
    );
    expect(
      container.read(updateWordInfoProvider(newinfo)),
      const AsyncValue<void>.loading(),
    );

    /// Wait for the request to finish
    await container.read(updateWordInfoProvider(newinfo).future);

    verify(() => db.upadateWordInf(1, newWord)).called(1);
  });
}
