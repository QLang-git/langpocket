import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'drift_group_repository.dart';
import 'package:langpocket/src/data/local/connection/connection.dart' as impl;

abstract class LocalGroupRepository {
  Future<List<GroupData>> fetchGroups();
  Stream<List<GroupData>> watchGroups();
  Future<GroupData> fetchGroupById(int groupId);
  Future<GroupData> fetchGroupByTime(DateTime now);
  Stream<GroupData> watchGroupById(int groupId);
  Future<GroupData> createGroup(GroupCompanion newgroup);
  Future<void> addNewWordInGroup(WordCompanion newWord);
  Future<WordData> fetchWordbyId(int groupId);
  Stream<List<WordData>> watchWordsByGroupId(int groupId);
  Future<List<WordData>> fetchWordsByGroupId(int groupId);
  Future<void> updateGroupName(int groupId, String newName);
  Future<void> deleteWordById(int wordId);
  Stream<WordData> watchWordById(int wordId);
  Future<void> upadateWordInf(int wordId, WordCompanion wordCompanion);
}

final localGroupRepositoryProvider = Provider<LocalGroupRepository>((ref) {
  final database = DriftGroupRepository(impl.connect());
  ref.onDispose(database.close);
  return database;
});
