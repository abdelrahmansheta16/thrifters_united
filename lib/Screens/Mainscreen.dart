import 'package:flutter/material.dart';
import 'package:thrifters_united/Screens/Cart.dart';
import 'package:thrifters_united/Screens/Categories.dart';
import 'package:thrifters_united/Screens/Homescreen.dart';
import 'package:thrifters_united/Screens/Profile.dart';
import 'package:thrifters_united/Screens/Wishlist.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ScreenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        key: globalKey,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
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
