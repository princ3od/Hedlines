import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hedlines/src/model/fake_model/social_model.dart';

class AuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<SocialModel?> signInWithGoogle() async {
    try {
      print("step in to 9");
      await GoogleSignIn().signOut();
      print("step in to 10");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("step in to 12");
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      print("step in to 14");
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("step in to 19");
      final UserCredential firebaseUserCredential = await FirebaseAuth.instance.signInWithCredential(googleCredential);

      if (firebaseUserCredential.user == null) {
        return null;
      }

      return SocialModel(
        fullName: googleUser.displayName ?? 'user.hedlines.google',
        googleId: firebaseUserCredential.user!.uid,
      );
    } catch (e) {
      return null;
    }
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
}
