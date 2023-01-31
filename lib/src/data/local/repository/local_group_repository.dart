import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/modules/group_module.dart';
import 'package:langpocket/src/data/modules/word_module.dart';

import 'drift_group_repository.dart';

abstract class LocalGroupRepository {
  Future<List<GroupData>> fetchGroups();
  Stream<List<GroupData>> watchGroups();
  Future<GroupData> fetchGroupById(int groupId);
  Future<GroupData> fetchGroupByTime(DateTime now);
  Stream<GroupData> watchGroupById(int groupId);
  Future<GroupData> createGroup(GroupCompanion newgroup);
  Future<WordData> addNewWordInGroup(WordCompanion newWord);
  Future<WordData> fetchWordbyId(int groupId);
}

final localGroupRepositoryProvider = Provider<LocalGroupRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
