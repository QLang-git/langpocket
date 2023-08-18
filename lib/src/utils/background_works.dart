// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:langpocket/src/data/remote/aws_db.dart';
import 'package:langpocket/src/data/services/data_sync.dart';
import 'package:workmanager/workmanager.dart';

import 'package:langpocket/amplifyconfiguration.dart';
import 'package:langpocket/models/ModelProvider.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final initialized = await _amplifyAuthInitialization();
    if (initialized) {
      final remoteDB = AwsDatabase();
      final localDB = safe_acess_local_db;
      final syncing = DataSync(localDB, remoteDB);
      if (task == 'PULL') {
        if (initialized) {
          print('............pull ............');

          syncing.pullRemoteChanges();
          return Future.value(true);
        }
      }
      if (task == 'PUSH') {
        print('...........push...............');
        syncing.pushLocalChanges();
        return Future.value(true);
      }

      return Future.value(false);
    } else {
      return Future.value(false);
    }
  });
}

class BackgroundWorks {
  BackgroundWorks();
  void initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  }

  void pullOut() async {
    await Workmanager().registerOneOffTask(
      'remoteDB',
      'PULL',
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  void pushIn() {
    Workmanager().registerOneOffTask(
      'remoteDB',
      'PUSH',
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }
}

Future<bool> _amplifyAuthInitialization() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(modelProvider: ModelProvider.instance),
      AmplifyStorageS3()
    ]);

    await Amplify.configure(amplifyconfig);

    return true;
  } catch (e) {
    print('auth field in background ... (((');
    return false;
  }
}
