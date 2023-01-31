import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/new_word/application/words_service.dart';

class WordController extends StateNotifier<AsyncValue<WordData>> {
  final WordsServices wordsServices;
  final WordData newWord;
  WordController({required this.wordsServices, required this.newWord})
      : super(const AsyncLoading());

  Future<bool> addNewWord() async {
    // validations
    if (newWord.foreignWord.isEmpty &&
        newWord.wordExamples.isEmpty &&
        newWord.wordMeans.isEmpty) {
      state = AsyncValue.error(
          'ONE of the required value not found', StackTrace.current);
      return false;
    }
    // get the group
    final now = DateTime.now();
    final res = await AsyncValue.guard(() async {
      final groupId = await checkTodayGroup(now, wordsServices);
      final newWordCompanion = WordCompanion.insert(
          group: groupId,
          foreignWord: newWord.foreignWord,
          wordMeans: newWord.wordImages,
          wordImages: newWord.wordImages,
          wordExamples: newWord.wordExamples,
          wordNote: newWord.wordNote,
          wordDate: newWord.wordDate);
      return await wordsServices.addNewWords(newWordCompanion);
    });
    if (res.hasError) {
      state = AsyncValue.error(res.error!, StackTrace.current);
      return false;
    } else {
      state = res;
      return true;
    }
  }
}

final wordIdProvider = StateProvider<String>((ref) {
  return '';
});
final groupId = StateProvider<String>((ref) {
  return '';
});

final foreignProvider = StateProvider<String>((ref) {
  return '';
});
final meansProvider = StateProvider<List<String>>((ref) {
  return List.filled(4, '', growable: true);
});
final examplesProvider = StateProvider<List<String>>((ref) {
  return List.filled(6, '', growable: true);
});
final imagesProvider = StateProvider<List<String>>((ref) {
  return [];
});
final noteProvider = StateProvider<String>((ref) {
  return '';
});

Future<int> checkTodayGroup(DateTime now, WordsServices wordsServices) async {
  final todayDate = DateTime(
    now.day,
    now.month,
    now.year,
  );
  try {
    final todayGroup = await wordsServices.fetchGroupByTime(now);
    return todayGroup.id;
  } catch (e) {
    final newGroup = await wordsServices.createGroup(GroupCompanion.insert(
        groupName: todayDate.toString(), creatingTime: now));
    return newGroup.id;
  }
}
