import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final routerControllerProvider = StateNotifierProvider<RouterController,
    AsyncValue<({bool isFirstTime, bool hasAuth})>>((ref) {
  return RouterController();
});

class RouterController
    extends StateNotifier<AsyncValue<({bool isFirstTime, bool hasAuth})>> {
  RouterController() : super(const AsyncLoading()) {
    initialize();
  }

  void initialize() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final firstTime = prefs.getBool('first_time') ?? true;
      return (isFirstTime: firstTime, hasAuth: false);
    });
  }

  void setFirstTimeToFalse() async {
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('first_time', false);
      return (isFirstTime: false, hasAuth: false);
    });
  }

  void continueWithGoogle() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );
      if (result.isSignedIn) {
        setFirstTimeToFalse();
      }
    } catch (e) {
      print(e); // Handle sign-in exception
    }
  }
}
