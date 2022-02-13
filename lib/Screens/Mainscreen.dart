import 'dart:async';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
  int _selectedIndex = 0;
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
    DioHelper.getData();
    FilterProvider.of(context, listen: false).setUsers();
    FilterProvider.of(context, listen: false).setCategories();
    FilterProvider.of(context, listen: false).setBrands();
    FilterProvider.of(context, listen: false).setSizes();
    FilterProvider.of(context, listen: false).setPriceRanges();
    FilterProvider.of(context, listen: false).setProducts();
    setupInteractedMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Consumer<AuthenticationAPI>(builder: (context, model, child) {
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
                            style: TextStyle(color: Colors.white, fontSize: 10),
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
    );
  }
}
