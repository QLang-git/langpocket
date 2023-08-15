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
  late SharedPreferences prefs;

  void initialize() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      prefs = await SharedPreferences.getInstance();
      final firstTime = prefs.getBool('first_time') ?? true;
      return (isFirstTime: firstTime, hasAuth: false);
    });
  }

  void setFirstTimeToFalse() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      prefs = await SharedPreferences.getInstance();
      await prefs.setBool('first_time', false);
      return (isFirstTime: false, hasAuth: false);
    });
  }

  Future<bool> continueWithGoogle() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );

      if (result.isSignedIn) {
        state = const AsyncLoading();
        state = const AsyncValue.data((isFirstTime: false, hasAuth: true));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> continueWithFacebook() async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);

      if (result.isSignedIn) {
        state = const AsyncLoading();
        state = const AsyncValue.data((isFirstTime: false, hasAuth: true));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
