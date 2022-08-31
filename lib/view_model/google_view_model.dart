import 'package:demo_authentication/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInNotifier extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);
  final firebaseAuth = FirebaseAuth.instance;

  GoogleSignInAccount? googleSignInAccount;
  GoogleSignInAccount get user => googleSignInAccount!;
  FirebaseAuth get auth => firebaseAuth;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if(googleUser == null) return;
      googleSignInAccount = googleUser;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await firebaseAuth.signInWithCredential(credential);
      notifyListeners();
    } catch(e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}