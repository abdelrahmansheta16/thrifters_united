import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EarnCredit extends StatefulWidget {
  const EarnCredit({Key key}) : super(key: key);

  @override
  _EarnCreditState createState() => _EarnCreditState();
}

class _EarnCreditState extends State<EarnCredit> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Refer and Earn',
          textAlign: TextAlign.start,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Image.network(
            'https://www.pinclipart.com/picdir/middle/552-5525945_social-media-sharing-png-clipart.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.38,
            fit: BoxFit.fitHeight,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.38,
              );
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                  color: Colors.black,
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Text(
              'Refer a friend and get EGP 100 in your wallet.\n\nHow does it work?\n\nLet your friends sign up using your link and they\'ll enjoy a 25% discount ( Maximum EGP50 ) off their first order, and you\'ll get EGP40 every time a new friend makes an order.\n\nThis invitation offer can\'t be used to the same address, using it for the same address even from different accounts, puts your account at the risk of being blocked by the system. Terms and conditions apply.\n\nShare the love.\n',
              style: FlutterFlowTheme.bodyText1,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Terms and Conditions',
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Your Invitation code',
              style: FlutterFlowTheme.bodyText1,
            ),
          ),
          Consumer<AuthenticationAPI>(builder: (widget, model, child) {
            return FutureBuilder<DocumentSnapshot<USER>>(
                future: UserAPI.getUser(model.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFCFCFCF),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Center(
                                child: Text(
                                  snapshot.data.data().rewards,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.bodyText1,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xFFE1E1E1),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.share_sharp,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Share.share(
                                  'Enjoy 25% discount at Thrifters. Use coupon code ${snapshot.data.data().rewards} on your first purchase. Visit Thrifters now: \nhttps://thrifters.page.link/post');
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
          SizedBox(
            height: 180,
          )
        ],
      ),
    );
  }
}
