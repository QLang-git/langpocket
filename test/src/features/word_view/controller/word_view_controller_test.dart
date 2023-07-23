import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/features/word_view/controller/word_view_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

void main() {
  test('watch Word by Id Provider', () async {
    final db = MockDriftGroupRepository();
    final word = WordData(
        id: 1,
        group: 1,
        foreignWord: 'foreignWord',
        wordMeans: 'wordMeans',
        wordImages: 'wordImages',
        wordExamples: 'wordExamples',
        wordNote: 'wordNote',
        wordDate: DateTime.now());
    when(() => db.watchWordById(1)).thenAnswer((_) => Stream.value(word));
    final container = ProviderContainer(
      overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
    );
    expect(
      container.read(watchWordbyIdProvider(1)),
      const AsyncValue<WordData>.loading(),
    );

    /// Wait for the request to finish
    await container.read(watchWordbyIdProvider(1).future);
    expect(container.read(watchWordbyIdProvider(1)).value, word);
    verify(() => db.watchWordById(1)).called(1);
  });
}
