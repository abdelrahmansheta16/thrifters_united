import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/Screens/Authentication.dart';
import 'package:thrifters_united/Screens/Cart.dart';
import 'package:thrifters_united/Screens/Categories.dart';
import 'package:thrifters_united/Screens/Homescreen.dart';
import 'package:thrifters_united/Screens/Profile.dart';
import 'package:thrifters_united/Screens/Wishlist.dart';
import 'package:thrifters_united/pages/Profile/MyAdresses.dart';
import 'package:thrifters_united/pages/Profile/MyOrders.dart';
import 'package:thrifters_united/pages/Profile/MyProfile.dart';

import 'Screens/Mainscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationAPI()),
        ChangeNotifierProvider(create: (context) => OrderAPI()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      future: Provider.of<AuthenticationAPI>(context, listen: false).getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Provider Demo',
            initialRoute: '/',
            routes: {
              '/': (context) => Mainscreen(),
              '/homescreen': (context) => Homescreen(),
              '/categories': (context) => Categories(),
              '/cart': (context) => Cart(),
              '/wishlist': (context) => Wishlist(),
              '/wishlist/authentication': (context) => AuthenticationWidget(),
              '/profile': (context) => Profile(),
              '/profile/MyProfile': (context) => MyProfile(),
              '/profile/MyAddresses': (context) => MyAddresses(),
              '/profile/MyOrders': (context) => MyOrders(),
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
