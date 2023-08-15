import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/remote/aws_db.dart';
import 'package:langpocket/src/data/local/connection/connection.dart' as impl;

class DataSync {
  final LocalGroupRepository localDB = DriftGroupRepository(impl.connect());
  final AwsDatabase remoteDB = AwsDatabase();

  DataSync();

  Future<void> syncData() async {
    await pullRemoteChanges();
    await pushLocalChanges();
  }

  Future<void> pullRemoteChanges() async {
    try {
      final remoteGroups = await remoteDB.fetchAllGroups();
      //  insert/update the pulled groups into  local database
      localDB.upsertGroups(remoteGroups);
    } catch (e) {
      print("Error pulling remote changes: $e");
    }
  }

  Future<void> pushLocalChanges() async {
    try {
      final unsyncedGroups = await localDB.fetchUnsyncedGroups();
      remoteDB.saveNewGroupWithWords(
        unsyncedGroups.groups,
        unsyncedGroups.words,
      );
    } catch (e) {
      print("Error pushing local changes: $e");
    }
  }
}
