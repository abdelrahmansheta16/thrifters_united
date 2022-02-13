import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

buildPopupDialog(BuildContext context, String message) {
  var signInAlert = CupertinoAlertDialog(title: Text(message), actions: [
    TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Retry')),
    TextButton(
        onPressed: ({bool animated}) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/wishlist/authentication');
          // Navigator.popUntil(context, (route) => false);
        },
        child: Text('Sign In')),
  ]);
  return showDialog(
      useRootNavigator: false,
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return signInAlert;
      });
}
