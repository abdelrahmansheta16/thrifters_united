import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/Screens/Homescreen.dart';
import 'package:thrifters_united/Screens/Mainscreen.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:thrifters_united/pages/PlacePicker.dart';

import '../FirebaseAPI/AuthenticationAPI.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Wishlist extends StatefulWidget {
  const Wishlist({Key key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationAPI>(builder: (context, model, child) {
      if (model.user == null) {
        return SignInWidget();
      }
      return WishlistWidget();
    });
  }
}

class WishlistWidget extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Wishlist',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_outlined,
              color: Color(0xFFC9C9C9),
              size: 124,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                'Your wish list is empty.\nYou can save products that you like by tapping on the heart icon',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF808080),
                  fontSize: 18,
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                final BottomNavigationBar navigationBar =
                    globalKey.currentWidget;
                navigationBar.onTap(0);
              },
              text: 'Go to Products',
              options: FFButtonOptions(
                width: 150,
                height: 30,
                color: Color(0xFF00BFA5),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_outlined,
            color: Color(0xFFC9C9C9),
            size: 124,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'If you saved any items in your wishlist, you see them here after you login',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Color(0xFF808080),
              ),
            ),
          ),
          FFButtonWidget(
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist/authentication');
            },
            text: 'SIGN IN',
            options: FFButtonOptions(
              width: 150,
              height: 30,
              color: Color(0xFF00BFA5),
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: 0,
            ),
          )
        ],
      ),
    );
  }
}
