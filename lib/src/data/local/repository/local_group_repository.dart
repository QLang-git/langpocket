import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/connection/web.dart';

import 'drift_group_repository.dart';

abstract class LocalGroupRepository {
  Future<List<GroupData>> fetchGroups();
  Stream<List<GroupData>> watchGroups();
  Future<GroupData> fetchGroupById(int groupId);
  Future<GroupData> fetchGroupByTime(DateTime now);
  Stream<GroupData> watchGroupById(int groupId);
  Future<GroupData> createGroup(GroupCompanion newgroup);
  Future<void> addNewWordInGroup(WordCompanion newWord);
  Future<WordData> fetchWordbyId(int groupId);
}

final localGroupRepositoryProvider = Provider<LocalGroupRepository>((ref) {
  final database = DriftGroupRepository();
  ref.onDispose(database.close);
  return database;
});
