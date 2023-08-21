import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/modules/user_module.dart';
import 'package:langpocket/src/utils/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appSettingsProvider = StateNotifierProvider.autoDispose<
    AppSettingsController, AsyncValue<SettingInfo>>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  return AppSettingsController(auth);
});

class AppSettingsController extends StateNotifier<AsyncValue<SettingInfo>> {
  final AuthRepository auth;
  AppSettingsController(this.auth) : super(const AsyncLoading()) {
    initialization();
  }

  void initialization() async {
    state = await AsyncValue.guard(() async {
      var user = await auth.getCurrentUser();
      final prefs = await SharedPreferences.getInstance();
      user ??= UserModule(
          name: ' Guest',
          email: '',
          isPro: false,
          photoUrl: 'assets/images/avatar.png');

      final studyLanguage = prefs.getString('studyLanguage') ?? 'English';
      const appVersion = 'v1';
      final studyTime = prefs.getString('studyTime') ?? '9:00 AM';
      return SettingInfo(
          studyTime: studyTime,
          userModule: user,
          studyLanguage: studyLanguage,
          appVersion: appVersion);
    });
  }

  void setTimeToStudy(String hour) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('timeToStudy', hour);
  }

  void setLanguageToStudy(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('getLanguage', language);
  }
}

class SettingInfo {
  final UserModule userModule;
  final String studyLanguage;
  final String appVersion;
  final String studyTime;

  SettingInfo({
    required this.studyTime,
    required this.userModule,
    required this.studyLanguage,
    required this.appVersion,
  });
}
