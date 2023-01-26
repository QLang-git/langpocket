import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/app.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:langpocket/src/screens/new_word/data/local/local_words_group_repository.dart';
import 'package:langpocket/src/screens/new_word/data/local/sembast_words_repo.dart';

void main() async {
  await runZonedGuarded(runAppSafely, errorHandle);
}

//! if the app run succesfuly
Future<void> runAppSafely() async {
  WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  //GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  usePathUrlStrategy();

  //* wait for repository to be created befor running the app
  final localNewWordRepo = await SembastWordsRepo.makeDefault();

  // * Entry point of the app
  runApp(ProviderScope(
      child: ProviderScope(overrides: [
    localWordsRepoProvider.overrideWithValue(localNewWordRepo)
  ], child: const App())));
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

//! if there is an error while app runing
void errorHandle(Object error, StackTrace stack) async {
  // * Log any errors to console
  debugPrint(error.toString());
}
