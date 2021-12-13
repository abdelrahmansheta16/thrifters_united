import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context,String message) {
  return new CupertinoAlertDialog(
      title: const Text('Connect to the Internet'),
      actions: [
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
}