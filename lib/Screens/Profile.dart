import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/GuestUser.dart';
import 'package:thrifters_united/customUi/dialogBuilder.dart';
import 'package:thrifters_united/main.dart';
import 'package:thrifters_united/pages/Profile/Balance.dart';
import 'package:thrifters_united/pages/Profile/EarnCredit.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:thrifters_united/pages/Profile/MyAddresses/MyAdresses.dart';
import '../FirebaseAPI/AuthenticationAPI.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Profile');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'MyProfile',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<AuthenticationAPI>(builder: (context, model, child) {
          return model.user == null
              ? GuestUser()
              : FutureBuilder<DocumentSnapshot<USER>>(
                  future:
                      UserAPI.getUser(FirebaseAuth.instance.currentUser.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    USER user = snapshot.data.data();
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  user == null ? 'Guest user' : user.name,
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              user == null
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 5),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              '/wishlist/authentication');
                                        },
                                        text: 'Sign in/Sign up',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 35,
                                          color: Colors.black,
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius: 0,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 10),
                                      child: Text(
                                        '${user.email}',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              // user == null
                              //     ? buildPopupDialog(
                              //         context, 'you must Sign in first')
                              //     : showModalBottomSheet(
                              //         context: context,
                              //         builder: (context) {
                              //           return LanguageAlertDialog(
                              //             currentLanguage: user.currentLanguage,
                              //           );
                              //         },
                              //       );
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Icon(
                                        EvaIcons.settings2Outline,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      'Egypt | English',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFF8D8D8D),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Row(
                                //   mainAxisSize: MainAxisSize.max,
                                //   children: [
                                //     Padding(
                                //       padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                //       child: Icon(
                                //         EvaIcons.giftOutline,
                                //         color: Colors.black,
                                //         size: 24,
                                //       ),
                                //     ),
                                //     Text(
                                //       'My Thrifters rewards',
                                //       style:
                                //           FlutterFlowTheme.bodyText1.override(
                                //         fontFamily: 'Poppins',
                                //       ),
                                //     )
                                //   ],
                                // ),
                                // Divider(
                                //   thickness: 1,
                                //   color: Color(0xFFC9C9C9),
                                // ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/profile/MyOrders');
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.shopping_bag_outlined,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'My Orders',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/profile/MyReturns');
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.assignment_returned_outlined,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'My Returns',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/profile/MyProfile');
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.person_outline_sharp,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'My Profile',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Balance(),
                                    ));
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.attach_money_sharp,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'My Credit',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => MyAddresses(
                                          user: user == null ? null : user),
                                    ));
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.delivery_dining,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'My Addresses',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                // Row(
                                //   mainAxisSize: MainAxisSize.max,
                                //   children: [
                                //     Padding(
                                //       padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                //       child: Icon(
                                //         Icons.credit_card_sharp,
                                //         color: Colors.black,
                                //         size: 24,
                                //       ),
                                //     ),
                                //     Text(
                                //       'My Cards',
                                //       style: FlutterFlowTheme.bodyText1.override(
                                //         fontFamily: 'Poppins',
                                //       ),
                                //     )
                                //   ],
                                // ),
                                // Divider(),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EarnCredit(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.money_sharp,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'Earn Credit',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                InkWell(
                                  onTap: (){
                                    Fluttertoast.showToast(msg: 'currently unavailabla');
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                          child: Icon(
                                            Icons.chat_bubble_outline_sharp,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                        Text(
                                          'FAQs  &  Contact Us',
                                          style:
                                              FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
        }),
      ),
    );
  }
}

class LanguageAlertDialog extends StatefulWidget {
  final String currentLanguage;
  const LanguageAlertDialog({Key key, this.currentLanguage}) : super(key: key);

  @override
  State<LanguageAlertDialog> createState() => _LanguageAlertDialogState();
}

class _LanguageAlertDialogState extends State<LanguageAlertDialog> {
  String activeButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeButton = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choose Language',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FFButtonWidget(
                  onPressed: () {
                    setState(() {
                      activeButton = 'ar';
                    });
                  },
                  text: 'Arabic',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: activeButton == 'ar' ? Colors.grey : Colors.white,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    borderSide: BorderSide(
                      color: Color(0xFF6B6B6B),
                      width: 1,
                    ),
                    borderRadius: 5,
                  ),
                ),
                FFButtonWidget(
                  onPressed: () {
                    setState(() {
                      activeButton = 'en';
                    });
                  },
                  text: 'English',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: activeButton == 'en' ? Colors.grey : Colors.white,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    borderSide: BorderSide(
                      color: Color(0xFF6B6B6B),
                      width: 1,
                    ),
                    borderRadius: 5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FFButtonWidget(
              onPressed: () {},
              text: 'Apply',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: Color(0xFF03CE9F),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
