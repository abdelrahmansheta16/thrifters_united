import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;

import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/main.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class AuthenticationAPI with ChangeNotifier {
  // var _googlesignin = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  USER googleUser;
  final UsersRef =
      FirebaseFirestore.instance.collection('users').withConverter<USER>(
            fromFirestore: (snapshot, _) => USER.fromJson(snapshot.data()),
            toFirestore: (user, _) => user.toJson(),
          );

  void setGoogleUser(USER user) {
    googleUser = user;
    notifyListeners();
  }

  void setUser(User currentUser) {
    user = currentUser;
    notifyListeners();
  }

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
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': user.displayName,
          'email': user.email,
          'userID': user.uid,
        },
        SetOptions(merge: true),
      );
      await FirebaseMessaging.instance.subscribeToTopic('newsletters');
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
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': user.displayName,
          'email': user.email,
          'userID': user.uid,
        },
        SetOptions(merge: true),
      );
      await FirebaseMessaging.instance.subscribeToTopic('newsletters');
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
      await FirebaseAuth.instance.signInWithPopup(googleProvider).then((value) {
        googleUser.userID = value.user.uid;
        FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'name': googleUser.name,
            'email': googleUser.email,
            'userID': googleUser.userID,
            'phoneNumber': googleUser.phoneNumber,
            'birthday': googleUser.birthday,
          },
          SetOptions(merge: true),
        );
      });

      await FirebaseMessaging.instance.subscribeToTopic('newsletters');
      notifyListeners();
    } else {
      googleSignInAccount = await googleSignIn.signIn();
      // await _googlesignin.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        googleUser.userID = value.user.uid;
        FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'name': googleUser.name,
            'email': googleUser.email,
            'userID': googleUser.userID,
            'phoneNumber': googleUser.phoneNumber,
            'birthday': googleUser.birthday,
          },
          SetOptions(merge: true),
        );
      });
      await FirebaseMessaging.instance.subscribeToTopic('newsletters');
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
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {
        'name': user.displayName,
        'email': user.email,
        'userID': user.uid,
      },
      SetOptions(merge: true),
    );
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
    await FirebaseMessaging.instance.subscribeToTopic('newsletters');
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {
        'name': user.displayName,
        'email': user.email,
        'userID': user.uid,
      },
      SetOptions(merge: true),
    );
    notifyListeners();
  }
}
