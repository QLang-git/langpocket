import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  AuthUser? user;

  Future<AuthUser?> getCurrentUser() async {
    try {
      user = await Amplify.Auth.getCurrentUser();
      print(user?.signInDetails.toString());
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> signWithGoogle() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );
      return result.isSignedIn;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signWithFacebook() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.facebook,
      );
      return result.isSignedIn;
    } catch (e) {
      return false;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
