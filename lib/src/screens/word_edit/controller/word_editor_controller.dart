import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/services/word_service.dart';

class NewWordInfo {
  final int wordId;
  final WordCompanion wordCompanion;

  NewWordInfo(this.wordId, this.wordCompanion);
}

final updateWordInfoProvider =
    FutureProvider.family<void, NewWordInfo>((ref, wordNew) async {
  await ref
      .watch(wordsServicesProvider)
      .updateWordInfo(wordNew.wordId, wordNew.wordCompanion);
});

final watchWordbyIdProvider =
    StreamProvider.family<WordData, int>((ref, wordId) {
  final words = ref.watch(wordsServicesProvider).watchWordById(wordId);

  return words;
});
