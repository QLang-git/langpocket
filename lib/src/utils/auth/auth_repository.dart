import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langpocket/src/data/modules/user_module.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {
  late FlutterSecureStorage storage;

  FlutterSecureStorage initializeStorage() {
    if (Platform.isAndroid) {
      return const FlutterSecureStorage(
          aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ));
    } else {
      return const FlutterSecureStorage();
    }
  }

  Future<UserModule?> getCurrentUser() async {
    final storage = initializeStorage();
    final isPro = await storage.read(key: 'isPro') == 'true';

    final name = FirebaseAuth.instance.currentUser?.displayName;
    final email = FirebaseAuth.instance.currentUser?.email;
    final image = FirebaseAuth.instance.currentUser?.photoURL;
    if (name != null && email != null && image != null) {
      return UserModule(
        name: name,
        email: email,
        isPro: isPro,
        photoUrl: image,
      );
    }
    return null;
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        _getCurrentUser(authResult);

        return true;
      } else {
        throw FirebaseAuthException(
          message: 'Sign in aborted by user',
          code: '',
        );
      }
    } catch (e) {
      throw FirebaseAuthException(
        message: 'Error during Google sign in: $e',
        code: '',
      );
    }
  }

  Future<bool> signWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;

        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        _getCurrentUser(authResult);

        return true;
      } else {
        throw FirebaseAuthException(
          message: 'Facebook login failed',
          code: '',
        );
      }
    } catch (e) {
      throw FirebaseAuthException(
        message: 'Error during Facebook login: $e',
        code: '',
      );
    }
  }

  void _getCurrentUser(UserCredential authResult) async {
    if (authResult.user != null) {
      final storage = initializeStorage();
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .get();
      if (userDoc.exists) {
        await storage.write(key: 'isPro', value: userDoc['isPro']);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'name': authResult.user!.displayName,
          'email': authResult.user!.email,
          'photoUrl': authResult.user!.photoURL,
          'isPro': false, // Set initial subscription
        });
        await storage.write(key: 'isPro', value: 'false');
      }
    }
    return null;
  }
}
