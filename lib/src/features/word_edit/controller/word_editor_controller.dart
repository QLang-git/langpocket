import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_controller/helper_functions.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/data/services/word_service.dart';

final wordEditorProvider =
    StateNotifierProvider<EditWordController, AsyncValue<WordRecord>>((ref) {
  final wordService = ref.watch(wordsServicesProvider);

  return EditWordController(wordService: wordService);
});

class EditWordController extends StateNotifier<AsyncValue<WordRecord>> {
  WordServices wordService;

  EditWordController({required this.wordService}) : super(const AsyncLoading());
  Future<void> getWord(int wordId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final word = await wordService.fetchWordById(wordId);
      return word.decoding();
    });
  }

  bool isWordInfoSimilar(WordRecord newWordRecord) {
    final newWord = newWordRecord.copyWith(
        wordExamples: newWordRecord.wordExamples
            .where((element) => element.isNotEmpty)
            .toList(),
        wordMeans: newWordRecord.wordMeans
            .where((element) => element.isNotEmpty)
            .toList());
    return state.value == newWord;
  }

  Future<bool> updateWordInfo(WordRecord newWordRecord) async {
    final wordId = newWordRecord.id!;
    final imagesPah = await saveImagesFiles(newWordRecord.wordImages);

    final wordCompanion = WordCompanion(
        foreignWord: Value(newWordRecord.foreignWord),
        wordMeans: Value(newWordRecord.wordMeans.encodingData()),
        wordExamples: Value(newWordRecord.wordExamples.encodingData()),
        wordImages: Value(imagesPah.encodingData()),
        wordNote: Value(newWordRecord.wordNote));
    try {
      await wordService.updateWordInfo(wordId, wordCompanion);
      state = AsyncData(newWordRecord);

      return true;
    } catch (e) {
      return false;
    }
  }
}
