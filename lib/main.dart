import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/app.dart';

void main() async {
  await runZonedGuarded(runAppSafely, errorHandle);
}

//! if the app run succesfuly
Future<void> runAppSafely() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * Entry point of the app
  runApp(const ProviderScope(child: App()));
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
