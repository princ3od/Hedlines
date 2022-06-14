import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hedlines/src/model/fake_model/social_model.dart';

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
    );
  } catch (e) {
    return null;
  }
}
