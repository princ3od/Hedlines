import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hedlines/src/controller/app_controller.dart';
import 'package:hedlines/src/model/fake_model/social_model.dart';

import '../../model/fake_model/account_model.dart';

class AuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<SocialModel?> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential firebaseUserCredential = await FirebaseAuth.instance.signInWithCredential(googleCredential);

      if (firebaseUserCredential.user == null) {
        return null;
      }

      return SocialModel(
        fullName: googleUser.displayName ?? 'user.hedlines.google',
        googleId: firebaseUserCredential.user!.uid,
        googleAvatar: firebaseUserCredential.user!.photoURL,
        email: firebaseUserCredential.user!.email,
      );
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
    AppController().signOut();
  }

  static final AuthService _authService = AuthService._internal();

  AuthService._internal();
  factory AuthService() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return _authService;
  }

  Future<UserModel?> getUserInfo(SocialModel socialModel) async {
    return null;
  }
}
