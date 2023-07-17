import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/remote/remote_group_repository.dart';

class RemoteDb implements RemoteGroupRepository {
  @override
  Future<void> addNewWordInGroup(WordCompanion newWord, int userId) {
    // TODO: implement addNewWordInGroup
    throw UnimplementedError();
  }

  @override
  Future<GroupData> createGroup(GroupCompanion newgroup, int userId) {
    // TODO: implement createGroup
    throw UnimplementedError();
  }

  @override
  Future<GroupData> fetchGroupById(int groupId, int userId) {
    // TODO: implement fetchGroupById
    throw UnimplementedError();
  }

  @override
  Future<GroupData> fetchGroupByTime(DateTime now, int userId) {
    // TODO: implement fetchGroupByTime
    throw UnimplementedError();
  }

  @override
  Future<List<GroupData>> fetchGroups(int userId) {
    // TODO: implement fetchGroups
    throw UnimplementedError();
  }

  @override
  Future<WordData> fetchWordById(int groupId) {
    // TODO: implement fetchWordbyId
    throw UnimplementedError();
  }

  @override
  Stream<GroupData> watchGroupById(int groupId, int userId) {
    // TODO: implement watchGroupById
    throw UnimplementedError();
  }

  @override
  Stream<List<GroupData>> watchGroups(int userId) {
    // TODO: implement watchGroups
    throw UnimplementedError();
  }

  @override
  Stream<List<WordData>> watchWordsByGroupId(int groupId) {
    // TODO: implement watchWordsByGroupId
    throw UnimplementedError();
  }

  @override
  Future<List<WordData>> fetchWordsByGroupId(int groupId) {
    // TODO: implement fetchWordsByGroupId
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroupName(int groupId, String newName) {
    // TODO: implement updateGroupName
    throw UnimplementedError();
  }

  @override
  Future<void> deleteWordById(int wordId) {
    // TODO: implement deleteWordById
    throw UnimplementedError();
  }

  @override
  Future<void> upadateWordInf(int wordId, WordCompanion wordCompanion) {
    // TODO: implement upadateWordInf
    throw UnimplementedError();
  }

  @override
  Stream<WordData> watchWordById(int wordId) {
    // TODO: implement watchWordById
    throw UnimplementedError();
  }

  // we tell the database where to store the data with this constructor
}
