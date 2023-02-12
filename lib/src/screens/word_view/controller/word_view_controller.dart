import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/services/word_service.dart';

final watchWordbyIdProvider =
    StreamProvider.family<WordData, int>((ref, wordId) {
  final words = ref.watch(wordsServicesProvider).watchWordById(wordId);

  return words;
});
