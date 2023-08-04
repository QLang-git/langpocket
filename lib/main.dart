import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/app.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await runZonedGuarded(runAppSafely, errorHandle);
}

//! if the app run successfully
Future<void> runAppSafely() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  //GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
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
