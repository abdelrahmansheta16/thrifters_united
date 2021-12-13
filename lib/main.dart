import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:thrifters_united/Screens/Cart.dart';
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

import 'FirebaseAPI/AddressAPI.dart';
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
  void initState() {
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
      debugShowCheckedModeBanner: false,
      title: 'Provider Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/homescreen': (context) => HomeScreen(),
        '/categories': (context) => Categories(),
        '/cart': (context) => Cart(),
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
}
