import 'dart:async';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/DioHelper.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Cart.dart';
import 'package:thrifters_united/pages/CartPage.dart';
import 'package:thrifters_united/Screens/Categories.dart';
import 'package:thrifters_united/Screens/Homescreen.dart';
import 'package:thrifters_united/Screens/Profile.dart';
import 'package:thrifters_united/Screens/Wishlist.dart';
import 'package:thrifters_united/models/Product.dart';

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainScreenState extends State<MainScreen> {
  DateTime timeBackPressed = DateTime.now();
  bool isActive = false;
  int _selectedIndex = 0;
  InternetConnectionStatus _connectionStatus;
  PendingDynamicLinkData initialLink;
  final InternetConnectionChecker _connectivity = InternetConnectionChecker();
  StreamSubscription<InternetConnectionStatus> _connectivitySubscription;
  bool allowClose = false;

  Widget _buildPopupDialog(BuildContext context) {
    return new CupertinoAlertDialog(
        title: const Text('Connect to the Internet'),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await initConnectivity();
              },
              child: Text('Retry')),
          TextButton(
              onPressed: ({bool animated}) async {
                await SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop', animated);
              },
              child: Text('Exit')),
        ]);
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<dynamic> _ScreenOptions = <dynamic>[
    HomeScreen(),
    // Categories(),
    Cart(),
    Wishlist(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print(message.data);
    print(message.data['message']);
    if (message.data['message'] == 'orders') {
      Navigator.pushNamed(
        context,
        '/profile/MyOrders',
      );
    }
    // Navigator.pushNamed(
    //   context,
    //   Orders.id,
    // );
    // arguments: MessageArguments(message, true));
  }

  @override
  void initState() {
    FilterProvider.of(context, listen: false).setUsers();
    FilterProvider.of(context, listen: false).setCategories();
    FilterProvider.of(context, listen: false).setBrands();
    FilterProvider.of(context, listen: false).setSizes();
    FilterProvider.of(context, listen: false).setPriceRanges();
    FilterProvider.of(context, listen: false).setProducts();
    FirebaseDynamicLinks.instance.getInitialLink().then((value) {
      initialLink = value;
    });
    _handleLink(initialLink);
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      if (dynamicLinkData.link.path == '/post') {
        print(dynamicLinkData.link.toString());
      }
    }).onError((error) {
      print(error);
    });
    setupInteractedMessage();
    // _connectionStatus =await InternetConnectionChecker().connectionStatus;
    _connectivitySubscription =
        _connectivity.onStatusChange.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    InternetConnectionStatus result = InternetConnectionStatus.disconnected;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.connectionStatus;
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(InternetConnectionStatus result) async {
    print('state: ${result}');

    switch (result) {
      case InternetConnectionStatus.connected:
        setState(() {
          _connectionStatus = result;
        });
        break;
      case InternetConnectionStatus.disconnected:
        setState(() {
          _connectionStatus = result;
          showDialog(
            useRootNavigator: false,
            useSafeArea: false,
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        });

        break;
      default:
        setState(
            () => _connectionStatus = InternetConnectionStatus.disconnected);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          Fluttertoast.showToast(msg: 'Press again to exit', fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: _connectionStatus == InternetConnectionStatus.disconnected
          ? Expanded(
              child: Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator())))
          : Scaffold(
              body: _ScreenOptions.elementAt(_selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                key: globalKey,
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.black38,
                showUnselectedLabels: true,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.homeOutline),
                    label: 'Home',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.category_outlined),
                  //   label: 'Categories',
                  // ),
                  BottomNavigationBarItem(
                    icon: Consumer<AuthenticationAPI>(
                        builder: (context, model, child) {
                      return Badge(
                        elevation: 0,
                        badgeColor: Color(0xff51c0a9),
                        showBadge: model.user == null ? false : true,
                        child: Icon(EvaIcons.shoppingCartOutline),
                        badgeContent: model.user == null
                            ? Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            : StreamBuilder<QuerySnapshot>(
                                stream: UserAPI.loadCart(
                                    FirebaseAuth.instance.currentUser.uid),
                                builder: (context, snapshot) {
                                  int cartLength = snapshot.data?.docs?.length;
                                  return Text(
                                    cartLength.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  );
                                }),
                      );
                    }),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline_sharp),
                    label: 'Wishlist',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      EvaIcons.personOutline,
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xff51c0a9),
                onTap: _onItemTapped,
              ),
            ),
    );
  }

  void _handleLink(PendingDynamicLinkData initialLink) {
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      if (deepLink.path == '/post') {
        print(initialLink.link.toString());
      }
    }
  }
}
