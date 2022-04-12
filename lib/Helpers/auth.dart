import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  UserCredential? credential;
  Map<String, dynamic>? userData;

  //Facebook
  Future<LoginResult> _initializeLoginToFacebook() async {
    final LoginResult result = await FacebookAuth.i.login(
      permissions: [
        'email',
        'public_profile',
      ],
    );
    return result;
  }

  Future<void> _getData() async {
    userData = await FacebookAuth.i.getUserData(
      fields: "name,email,picture.width(800)",
    );
  }

  Future<String> loginToFacebook() async {
    final LoginResult result = await _initializeLoginToFacebook();
    if (result.status == LoginStatus.success) {
      final OAuthCredential userCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      credential =
          await FirebaseAuth.instance.signInWithCredential(userCredential);
      await _getData();
      if (userData != null) {
        return 'pass';
      } else {
        return 'error';
      }
    } else if (result.status == LoginStatus.cancelled) {
      return 'cancel';
    } else {
      return 'error';
    }
  }

  //Google
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<String> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return 'error';
      } else {
        final googleAuth = await googleUser.authentication;
        final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
        userData = {
          'email': googleUser.email,
          'name': googleUser.displayName,
          'picture': {
            'data': {
              'url': googleUser.photoUrl,
            }
          }
        };
        return 'pass';
      }
    } catch (error) {
      return 'error';
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
    } else {
      await FacebookAuth.instance.logOut();
    }
  }
}
