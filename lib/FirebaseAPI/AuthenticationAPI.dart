import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nanoid/nanoid.dart';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:thrifters_united/main.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class AuthenticationAPI with ChangeNotifier {
  // var _googlesignin = GoogleSignIn();
  final _fcm = FirebaseMessaging.instance;
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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      user = userCredential.user;
      if (userCredential.additionalUserInfo.isNewUser) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set(
          {
            'rewards': nanoid(5),
          },
          SetOptions(merge: true),
        );
      }
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': user.displayName,
          'email': user.email,
          'userID': user.uid,
          'token': _fcm.getToken(),
        },
        SetOptions(merge: true),
      );
      await FirebaseMessaging.instance.subscribeToTopic('newsletters');
      notifyListeners();
    } else {
      final token = await _fcm.getToken();
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      user = userCredential.user;
      if (userCredential.additionalUserInfo.isNewUser) {
        UsersRef.doc(user.uid).set(
          USER(
            name: user.displayName,
            email: user.email,
            userID: user.uid,
            token: token,
            rewards: nanoid(5),
          ),
          SetOptions(merge: true),
        );
      }
      //     .then((value) {
      //   if (userCredential.additionalUserInfo.isNewUser) {
      //     FirebaseFirestore.instance
      //         .collection('users')
      //         .doc(userCredential.user.uid)
      //         .set(
      //       {
      //         'rewards': nanoid(5),
      //       },
      //       SetOptions(merge: true),
      //     );
      //   }
      // });
      await FirebaseMessaging.instance.subscribeToTopic('newsletters');
      notifyListeners();
    }
  }

  signInWithGoogle() async {
    final token = await _fcm.getToken();
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      user = userCredential.user;
      FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': user.displayName,
          'email': user.email,
          'userID': user.uid,
          'token': token,
        },
        SetOptions(merge: true),
      );
      if (userCredential.additionalUserInfo.isNewUser) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set(
          {
            'rewards': nanoid(5),
          },
          SetOptions(merge: true),
        );
      }

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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      user = userCredential.user;
      if (userCredential.additionalUserInfo.isNewUser) {
        UsersRef.doc(user.uid).set(
          USER(
            name: user.displayName,
            email: user.email,
            userID: user.uid,
            token: token,
            rewards: nanoid(5),
          ),
          SetOptions(merge: true),
        );
      }

      //     .then((value) {
      //   if (userCredential.additionalUserInfo.isNewUser) {
      //     FirebaseFirestore.instance
      //         .collection('users')
      //         .doc(userCredential.user.uid)
      //         .set(
      //       {
      //         'rewards': nanoid(5),
      //       },
      //       SetOptions(merge: true),
      //     );
      //   }
      // });
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
    // await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
    //   {
    //     'name': user.displayName,
    //     'email': user.email,
    //     'userID': user.uid,
    //   },
    //   SetOptions(merge: true),
    // );
    notifyListeners();
  }

  bool checkUserLoggedIn(User user) {
    return user != null;
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

  registerWithEmailandPassword(String email, String password, String firstName,
      String lastName, String gender) async {
    String token = await _fcm.getToken();
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    if (userCredential.additionalUserInfo.isNewUser) {
      UsersRef.doc(user.uid).set(
        USER(
          name: '${firstName} ${lastName}',
          email: user.email,
          gender: gender,
          userID: user.uid,
          token: token,
          rewards: nanoid(5),
        ),
        SetOptions(merge: true),
      );
    }
    await FirebaseMessaging.instance.subscribeToTopic('newsletters');
    notifyListeners();
  }
}
