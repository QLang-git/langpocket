import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/remote/aws_db.dart';

class DataSync {
  final LocalGroupRepository localDB;
  final AwsDatabase remoteDB;

  DataSync(this.localDB, this.remoteDB);

  Future<void> syncData() async {
    pullRemoteChanges();
    pushLocalChanges();
  }

  void pullRemoteChanges() async {
    try {
      final remoteGroups = await remoteDB.syncDataFromCloud();
      //  insert/update the pulled groups into  local database
      await localDB.upsertGroups(remoteGroups);
    } catch (e) {
      print("Error pulling remote changes: $e");
    }
  }

  void pushLocalChanges() async {
    try {
      final unsyncedGroups = await localDB.fetchUnsyncedGroups();
      remoteDB.syncDataToCloud(
        unsyncedGroups.groups,
        unsyncedGroups.words,
      );
    } catch (e) {
      print("Error pushing local changes: $e");
    }
  }
}

final dataSyncProvider = Provider<DataSync>((ref) {
  final localDB = ref.watch(localGroupRepositoryProvider);
  final remoteDB = ref.watch(awsDBProvider);
  return DataSync(localDB, remoteDB);
});
