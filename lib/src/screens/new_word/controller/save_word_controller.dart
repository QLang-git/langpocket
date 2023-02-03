import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/remote/remote_group_repository.dart';
import 'package:langpocket/src/screens/new_word/application/words_service.dart';

class SaveWordController extends StateNotifier<AsyncValue<void>> {
  final WordsServices wordsServices;

  SaveWordController({
    required this.wordsServices,
  }) : super(const AsyncLoading());

  Future<void> addNewWord({
    required String foreignWord,
    required String wordMeans,
    required String wordImages,
    required String wordExamples,
    required String wordNote,
  }) async {
    // validations
    if (foreignWord.isEmpty && wordExamples.isEmpty && wordMeans.isEmpty) {
      state = AsyncValue.error(
          'ONE of the required value not found', StackTrace.current);
    }
    // get the group
    final now = DateTime.now();
    final res = await AsyncValue.guard(() async {
      final groupId = await _checkTodayGroup(now, wordsServices);
      final newWordCompanion = WordCompanion.insert(
          group: groupId,
          foreignWord: foreignWord,
          wordMeans: wordImages,
          wordImages: wordImages,
          wordExamples: wordExamples,
          wordNote: wordNote,
          wordDate: now);
      await wordsServices.addNewWordInGroup(newWordCompanion);
      print('great is saved');
      return true;
    });
    if (res.hasError) {
      state = AsyncValue.error(res.error!, StackTrace.current);
    } else {
      state = res;
    }
  }

  //! helper function
  Future<int> _checkTodayGroup(
      DateTime now, WordsServices wordsServices) async {
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
}

final saveWordControllerProvider =
    StateNotifierProvider.autoDispose<SaveWordController, AsyncValue<void>>(
        (ref) => SaveWordController(
              wordsServices: ref.watch(wordsServicesProvider),
            ),
        dependencies: [
      wordsServicesProvider,
    ]);
