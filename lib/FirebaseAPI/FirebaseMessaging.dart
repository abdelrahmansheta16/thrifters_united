import 'package:firebase_messaging/firebase_messaging.dart';

class BackgroundMessaging {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
