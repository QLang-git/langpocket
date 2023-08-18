import 'dart:async';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/amplifyconfiguration.dart';
import 'package:langpocket/models/ModelProvider.dart';
import 'package:langpocket/src/app.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:langpocket/src/utils/background_works.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

void main() async {
  await runZonedGuarded(runAppSafely, errorHandle);
}

//! if the app run successfully
Future<void> runAppSafely() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await _amplifyAuthInitialization();
  final backgroundWorks = BackgroundWorks();
  backgroundWorks.initialize();

  usePathUrlStrategy();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // * Entry point of the app
  runApp(const ProviderScope(child: App()));
  FlutterNativeSplash.remove();
//* if any uncaught Error happens
  errorScreen();
}

//! This code will present some error UI if any uncaught exception happens
void errorScreen() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

//! if there is an error while app running
void errorHandle(Object error, StackTrace stack) async {
  // * Log any errors to console
  debugPrint(error.toString());
}

Future<void> _amplifyAuthInitialization() async {
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(modelProvider: ModelProvider.instance),
      AmplifyStorageS3()
    ]);

    await Amplify.configure(amplifyconfig);
  } catch (e) {
    errorScreen();
    print('auth field ... (((');
  }
}
