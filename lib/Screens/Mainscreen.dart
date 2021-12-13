import 'dart:async';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Cart.dart';
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
    Categories(),
    Cart(),
    Wishlist(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   FirebaseAuth.instance.userChanges().listen((user) {
  // setState before dispose
  //     if (mounted) {
  //       setState(() {});
  //     }
  //     // setState(() {});
  //   });
  //   super.initState();
  // }

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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Consumer<AuthenticationAPI>(builder: (context, model, child) {
              return Badge(
                elevation: 0,
                badgeColor: Color(0xff51c0a9),
                showBadge: model.user == null ? false : true,
                child: Icon(Icons.shopping_cart_outlined),
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
                          // if (snapshot.hasError) {
                          // return SizedBox();
                          // }
                          //
                          // if (snapshot.connectionState ==
                          // ConnectionState.waiting) {
                          // return Center(
                          // child: CircularProgressIndicator(
                          // color: Colors.white,
                          // ));
                          // }
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
              Icons.person_outline_sharp,
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
