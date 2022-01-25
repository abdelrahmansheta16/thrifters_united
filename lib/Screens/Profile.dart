import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
        child: StreamBuilder<User>(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              User user = snapshot.data;
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
                          child: Consumer<AuthenticationAPI>(
                              builder: (context, model, child) {
                            if (model.user == null) {
                              return Text(
                                'Guest user',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return Text(
                              "${model.user.displayName}",
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ),
                        Consumer<AuthenticationAPI>(
                          builder: (context, model, child) {
                            if (model.user == null) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/wishlist/authentication');
                                  },
                                  text: 'Sign in/Sign up',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 35,
                                    color: Colors.black,
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: 0,
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                '${model.user.email}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
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
                              'Saudi Arabia|English',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Icon(
                                  EvaIcons.giftOutline,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'My Thrifters rewards',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFFC9C9C9),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile/MyOrders');
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    'My Orders',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Icon(
                                  Icons.assignment_returned_outlined,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'My Returns',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
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
                                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Icon(
                                      Icons.person_outline_sharp,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    'My Profile',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Icon(
                                  Icons.attach_money_sharp,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'My Credit',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyAddresses(
                                    userID: user == null ? null : user.uid),
                              ));
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Icon(
                                      Icons.delivery_dining,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    'My Addresses',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Icon(
                                  Icons.credit_card_sharp,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'My Cards',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Icon(
                                  Icons.money_sharp,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'Earn Credit',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
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
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
