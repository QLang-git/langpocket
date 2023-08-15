import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:langpocket/amplifyconfiguration.dart';
import 'package:langpocket/models/ModelProvider.dart';
import 'package:langpocket/src/data/services/data_sync.dart';
import 'package:workmanager/workmanager.dart';

const myTask = "syncWithAWS";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == myTask) {
      final initialized = await _amplifyAuthInitialization();
      if (initialized) {
        final syncing = DataSync();
        await syncing.syncData();
      }
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  });
}

class BackgroundWorks {
  void initialize() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  }

  void scheduleBackgroundTask() {
    Workmanager().registerOneOffTask(
      'remoteDB',
      myTask,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }
}

Future<bool> _amplifyAuthInitialization() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyDataStore(modelProvider: ModelProvider.instance),
      AmplifyStorageS3()
    ]);

    await Amplify.configure(amplifyconfig);

    return true;
  } catch (e) {
    print('auth field ... (((');
    return false;
  }
}
