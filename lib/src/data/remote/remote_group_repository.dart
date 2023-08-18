import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/remote/remote_db.dart';

abstract class RemoteGroupRepository {
  Future<List<GroupData>> fetchGroups(int userId);
  Stream<List<GroupData>> watchGroups(int userId);
  Future<GroupData> fetchGroupById(int groupId, int userId);
  Stream<GroupData> watchGroupById(int groupId, int userId);
  Future<GroupData> createGroup(GroupCompanion newgroup, int userId);
  Future<void> addNewWordInGroup(WordCompanion newWord, int userId);
  Future<WordData> fetchWordById(int groupId);
  Future<List<WordData>> fetchAllWords();
  Future<GroupData> fetchGroupByTime(DateTime now, int userId);
  Stream<List<WordData>> watchWordsByGroupId(int groupId);
  Future<List<WordData>> fetchWordsByGroupId(int groupId);
  Future<void> updateGroupName(int groupId, String newName);
  Future<void> deleteWordById(int wordId);
  Future<void> upadateWordInf(int wordId, WordCompanion wordCompanion);
  Stream<WordData> watchWordById(int wordId);
  Future<List<GroupData>> fetchAllGroups();
  Future<void> updateGroupLevel(int groupId, int newLevel);
}

final remoteGroupRepositoryProvider = Provider<RemoteGroupRepository>((ref) {
  return RemoteDb();
});
