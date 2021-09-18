import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;

import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/models/User.dart';

class AuthenticationAPI with ChangeNotifier {
  var _googlesignin = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  Future<void> signInWithFacebook() async {
    if (kIsWeb) {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Once signed in, return the UserCredential
      user = await FirebaseAuth.instance
          .signInWithPopup(facebookProvider)
          .then((value) => value.user);
      await UserAPI.addUser(
        user: USER(userID: user.uid, name: user.displayName),
      );

      notifyListeners();
    } else {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      // Once signed in, return the UserCredential
      user = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((value) => value.user);
      await UserAPI.addUser(
          user: USER(userID: user.uid, name: user.displayName));
      notifyListeners();
    }
  }

  signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      user = await FirebaseAuth.instance
          .signInWithPopup(googleProvider)
          .then((value) => value.user);
      await UserAPI.addUser(
          user: USER(userID: user.uid, name: user.displayName));
      notifyListeners();
    } else {
      googleSignInAccount = await _googlesignin.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      user = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => value.user);
      await UserAPI.addUser(
          user: USER(userID: user.uid, name: user.displayName));
      notifyListeners();
    }
  }

  signInWithEmailAndPassword(String email, String password) async {
    user = await auth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => value.user);
    await UserAPI.addUser(user: USER(userID: user.uid, name: user.displayName));
    notifyListeners();
  }

  bool checkUserloggedin(User user) {
    user == null ? false : true;
  }

  Future getUser() async {
    user = await auth.currentUser;
    notifyListeners();
  }

  Future signOut() async {
    await auth.signOut();
    user = null;
    notifyListeners();
  }

  registerWithEmailandPassword(String email, String password) async {
    user = await auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => value.user);
    await UserAPI.addUser(user: USER(userID: user.uid, name: user.displayName));
    notifyListeners();
  }
}
