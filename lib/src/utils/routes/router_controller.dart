import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/utils/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final routerControllerProvider = StateNotifierProvider<RouterController,
    AsyncValue<({bool isFirstTime, bool hasAuth})>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RouterController(authRepository);
});

class RouterController
    extends StateNotifier<AsyncValue<({bool isFirstTime, bool hasAuth})>> {
  final AuthRepository authRepository;
  RouterController(this.authRepository) : super(const AsyncLoading()) {
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
    final res = await authRepository.signWithGoogle();
    if (res) {
      state = const AsyncLoading();
      state = const AsyncValue.data((isFirstTime: false, hasAuth: true));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> continueWithFacebook() async {
    final res = await authRepository.signWithFacebook();
    if (res) {
      state = const AsyncLoading();
      state = const AsyncValue.data((isFirstTime: false, hasAuth: true));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logOut() async {
    final res = await authRepository.logout();
    if (res) {
      state = const AsyncLoading();
      state = const AsyncValue.data((isFirstTime: false, hasAuth: false));
      return true;
    } else {
      return false;
    }
  }
}
