import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class WordRecordNotifier extends StateNotifier<AsyncValue<WordRecord>> {
  final Future<WordData> wordDataFuture;
  WordRecordNotifier(this.wordDataFuture) : super(const AsyncValue.loading());

  void setWord() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => wordDataFuture.then((value) => value.decoding()));
  }
}

final wordRecordsProvider = StateNotifierProvider.family<WordRecordNotifier,
    AsyncValue<WordRecord>, int>(
  (ref, wordId) {
    final currentWord = ref.watch(wordsServicesProvider).fetchWordById(wordId);
    return WordRecordNotifier(currentWord);
  },
);
