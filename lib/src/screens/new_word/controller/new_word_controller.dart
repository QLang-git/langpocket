import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/application/words_service.dart';
import 'package:langpocket/src/screens/new_word/data/domain/group_words_model.dart';
import 'package:langpocket/src/screens/new_word/data/domain/word_model.dart';

class NewWordController extends StateNotifier<AsyncValue<Word>> {
  final WordsServices wordsServices;
  final Word newWord;
  NewWordController({required this.wordsServices, required this.newWord})
      : super(const AsyncLoading());

  bool setNewWord() {
    if (newWord.foreign.isEmpty &&
        newWord.examples.isEmpty &&
        newWord.means.isEmpty) {
      state = AsyncValue.error(
          'ONE of the required value not found', StackTrace.current);
      return false;
    }

    state = AsyncData(Word(
        wordId: newWord.wordId,
        images: newWord.images,
        foreign: newWord.foreign,
        means: newWord.means,
        examples: newWord.examples,
        note: newWord.note));
    return true;
  }

  Future<void> saveWordInGroup(String groupWordsId, String wordId) async {
    final validation = setNewWord();
    if (!validation) {
      return;
    }
    state = const AsyncLoading<Word>().copyWithPrevious(state);
    final res = await AsyncValue.guard(() async {
      final words = await wordsServices.findWordListInGroup(groupWordsId);
      final List<Word> withNewWord = [...words, state.value!];
      final group = GroupWords(groupWordsId, withNewWord);
      return wordsServices.addGroupWords(group);
    });
    if (res.hasError) {
      state = state = AsyncValue.error(res.error!, StackTrace.current);
    }
  }
}

// final newWordControllerProvider =
//     StateNotifierProvider<NewWordController, AsyncValue<Word>>((ref) {
//  // final getWord = AddNewWord(ref).getWord();
//   return NewWordController(
//       wordsServices: ref.watch(wordsServicesProvider), newWord: getWord);
// });

//! Assemble the components of the word
class AddNewWord {
  final WidgetRef ref;

  AddNewWord(this.ref);

  Word getWord() {
    return Word(
        wordId: ref.watch(wordIdProvider),
        images: ref.watch(imagesProvider),
        foreign: ref.watch(foreignProvider),
        means: ref.watch(meansProvider),
        examples: ref.watch(examplesProvider),
        note: ref.watch(noteProvider));
  }
}

final wordIdProvider = StateProvider<String>((ref) {
  return '';
});
final foreignProvider = StateProvider<String>((ref) {
  return '';
});
final meansProvider = StateProvider<List<String>>((ref) {
  return [];
});
final examplesProvider = StateProvider<List<String>>((ref) {
  return [];
});
final imagesProvider = StateProvider<List<String>>((ref) {
  return [];
});
final noteProvider = StateProvider<String>((ref) {
  return '';
});
