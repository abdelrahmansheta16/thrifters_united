import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis/content/v2_1.dart' as v2;
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis/people/v1.dart' as gas;
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/FirebaseAPI/LocationProvider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Authentication.dart';
import 'package:thrifters_united/pages/CartPage.dart';
import 'package:thrifters_united/Screens/Categories.dart';
import 'package:thrifters_united/Screens/Homescreen.dart';
import 'package:thrifters_united/Screens/Profile.dart';
import 'package:thrifters_united/Screens/Wishlist.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/pages/Maps/GoogleMaps.dart';
import 'package:thrifters_united/pages/Profile/MyAddresses/AddAddress.dart';
import 'package:thrifters_united/pages/Profile/MyAddresses/MyAdresses.dart';
import 'package:thrifters_united/pages/Profile/MyOrders.dart';
import 'package:thrifters_united/pages/Profile/MyProfile.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:thrifters_classes/utils.dart';
import 'package:thrifters_united/pages/Shopping/ChooseAddress.dart';

import 'FirebaseAPI/AddressAPI.dart';
import 'FirebaseAPI/FirebaseMessaging.dart';
import 'FirebaseAPI/NotificationAPI.dart';
import 'Screens/Mainscreen.dart';

final GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '[YOUR_OAUTH_2_CLIENT_ID]',
  scopes: <String>[
    gas.PeopleServiceApi.userPhonenumbersReadScope,
    gas.PeopleServiceApi.userGenderReadScope,
    gas.PeopleServiceApi.userBirthdayReadScope,
    gas.PeopleServiceApi.userAddressesReadScope,
    gas.PeopleServiceApi.userinfoProfileScope,
  ],
);

String initialRoute;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
      ledColor: Colors.teal,
      enableLights: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationAPI()),
        ChangeNotifierProvider(create: (context) => OrderAPI()),
        ChangeNotifierProvider(create: (context) => AddressAPI()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleSignInAccount _currentUser;
  String _contactText = '';

  @override
  Future<void> initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      Provider.of<AuthenticationAPI>(context, listen: false).setUser(event);
    });
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: true,
          sound: true,
        )
        .then((value) =>
            print('User granted permission: ${value.authorizationStatus}'));

    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    NotificationAPI.init();
    NotificationAPI.requestPermissions();
    // listenNotifications();
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    BackgroundMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message: ${message.data}');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: "@drawable/splash",
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                // icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print('A new getInitialMessage event was published!');
      // Navigator.pushNamed(
      //   context,
      //   Orders.id,
      // );
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // _googleSignIn.signIn().then((value) => print(value.displayName));
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = 'Loading contact info...';
    });

    // Retrieve an [auth.AuthClient] from the current [GoogleSignIn] instance.
    final auth.AuthClient client = await googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');

    // Prepare a People Service authenticated client.
    final gas.PeopleServiceApi peopleApi = gas.PeopleServiceApi(client);
    // Retrieve a list of the `names` of my `connections`
    final gas.Person response = await peopleApi.people.get(
      'people/me',
      personFields:
          'names,addresses,birthdays,emailAddresses,genders,locations,phoneNumbers,',
    );

    _pickFirstNamedContact(response);

    // setState(() {
    //   if (firstNamedContactName != null) {
    //     _contactText = 'I see you know $firstNamedContactName!';
    //   } else {
    //     _contactText = 'No contacts to display.';
    //   }
    // });
  }

  void _pickFirstNamedContact(gas.Person person) {
    print(person.names);
    USER user = USER(
        // userID: FirebaseAuth.instance.currentUser.uid,
        name: person.names.first.displayName,
        gender: person.genders.first.value,
        phoneNumber: person.phoneNumbers?.first?.formattedType,
        email: person.emailAddresses.first.value,
        addresses: person.addresses?.map((address) {
          return address.formattedType;
        })?.toList(),
        birthday: Utils.fromDateTimeToJson(DateTime(
            person.birthdays.first.date.year,
            person.birthdays.first.date.month,
            person.birthdays.first.date.day)));
    // UserAPI.setUser(user: user);
    Provider.of<AuthenticationAPI>(context, listen: false).setGoogleUser(user);
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: _handleGetContact,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      supportedLocales: [
        Locale("af"),
        Locale("am"),
        Locale("ar"),
        Locale("az"),
        Locale("be"),
        Locale("bg"),
        Locale("bn"),
        Locale("bs"),
        Locale("ca"),
        Locale("cs"),
        Locale("da"),
        Locale("de"),
        Locale("el"),
        Locale("en"),
        Locale("es"),
        Locale("et"),
        Locale("fa"),
        Locale("fi"),
        Locale("fr"),
        Locale("gl"),
        Locale("ha"),
        Locale("he"),
        Locale("hi"),
        Locale("hr"),
        Locale("hu"),
        Locale("hy"),
        Locale("id"),
        Locale("is"),
        Locale("it"),
        Locale("ja"),
        Locale("ka"),
        Locale("kk"),
        Locale("km"),
        Locale("ko"),
        Locale("ku"),
        Locale("ky"),
        Locale("lt"),
        Locale("lv"),
        Locale("mk"),
        Locale("ml"),
        Locale("mn"),
        Locale("ms"),
        Locale("nb"),
        Locale("nl"),
        Locale("nn"),
        Locale("no"),
        Locale("pl"),
        Locale("ps"),
        Locale("pt"),
        Locale("ro"),
        Locale("ru"),
        Locale("sd"),
        Locale("sk"),
        Locale("sl"),
        Locale("so"),
        Locale("sq"),
        Locale("sr"),
        Locale("sv"),
        Locale("ta"),
        Locale("tg"),
        Locale("th"),
        Locale("tk"),
        Locale("tr"),
        Locale("tt"),
        Locale("uk"),
        Locale("ug"),
        Locale("ur"),
        Locale("uz"),
        Locale("vi"),
        Locale("zh")
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light),
          )),
      debugShowCheckedModeBanner: false,
      title: 'Provider Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/homescreen': (context) => HomeScreen(),
        '/categories': (context) => Categories(),
        '/cart': (context) => CartPage(),
        '/cart/checkout/chooseAddress': (context) => chooseAddress(),
        '/wishlist': (context) => Wishlist(),
        '/wishlist/authentication': (context) => AuthenticationWidget(),
        '/profile': (context) => Profile(),
        '/profile/MyProfile': (context) => MyProfile(),
        '/profile/MyAddresses': (context) => MyAddresses(),
        '/profile/MyAddresses/AddAddress': (context) => AddAddress(),
        '/profile/MyOrders': (context) => MyOrders(),
        '/profile/MyAddresses/AddAddress/Maps': (context) => MapScreen(),
      },
    );
  }

  // void listenNotifications() {
  //   NotificationAPI.selectNotificationSubject.stream
  //       .listen(onClickedNotification);
  // }
  //
  // void onClickedNotification(String payload) {
  //   print('payload is: ${payload}');
  //   // Navigator.pushNamed(
  //   //   context,
  //   //   '/profile/MyOrders',
  //   // );
  // }
}
