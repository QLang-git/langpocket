import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/services/word_service.dart';

class DataFlow {
  final WidgetRef ref;

  DataFlow({required this.ref});

  void deleteWordInGroup(int wordId, int groupId) async =>
      await ref.watch(wordsServicesProvider).deleteWordById(wordId, groupId);

  AsyncValue<List<WordData>> watchWordsListbyId(int currentGroupId) {
    return ref.watch(_watchWordsListbyId(currentGroupId));
  }

  AsyncValue<List<GroupData>> watchAllGroups() {
    return ref.watch(_watchAllGroups);
  }

  AsyncValue<void> updateGroupNameProvider(int groupId, String newName) {
    return ref
        .read(_updateGroupNameProvider((groupId: groupId, groupName: newName)));
  }

  AsyncValue<WordData> fetchWordById(int currentGroupId) {
    return ref.watch(_fetchWordById(currentGroupId));
  }

  final _fetchWordById = FutureProvider.family<WordData, int>((ref, wordId) {
    return ref.watch(wordsServicesProvider).fetchWordById(wordId);
  });

  final _watchWordsListbyId = StreamProvider.family<List<WordData>, int>(
      (ref, groupId) =>
          ref.watch(wordsServicesProvider).watchWordsGroupId(groupId));

  final _watchAllGroups = StreamProvider<List<GroupData>>(
      (ref) => ref.watch(wordsServicesProvider).watchGroups());

  final _updateGroupNameProvider =
      FutureProvider.family<void, ({int groupId, String groupName})>(
          (ref, groupInfo) async {
    await ref
        .watch(wordsServicesProvider)
        .updateGroupName(groupInfo.groupId, groupInfo.groupName);
  });
}
