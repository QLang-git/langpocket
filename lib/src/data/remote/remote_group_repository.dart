import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';

abstract class RemoteGroupRepository {
  Future<List<GroupData>> fetchGroups(int userId);
  Stream<List<GroupData>> watchGroups(int userId);
  Future<GroupData> fetchGroupById(int groupId, int userId);
  Stream<GroupData> watchGroupById(int groupId, int userId);
  Future<GroupData> createGroup(GroupCompanion newgroup, int userId);
  Future<WordData> addNewWordInGroup(WordCompanion newWord, int userId);
  Future<WordData> fetchWordbyId(int groupId);
  Future<GroupData> fetchGroupByTime(DateTime now, int userId);
}

final remoteGroupRepositoryProvider = Provider<RemoteGroupRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
