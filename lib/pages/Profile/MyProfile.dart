import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/GuestUser.dart';
import 'package:thrifters_united/customUi/AccountInfoContainer.dart';
import 'package:thrifters_united/customUi/NotificationSubscribtionContainer.dart';
import 'package:thrifters_united/customUi/PhoneNumberWidget.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import '../../FirebaseAPI/AuthenticationAPI.dart';
import '../../utils.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'MyProfile',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Consumer<AuthenticationAPI>(builder: (context, model, child) {
          if (model.user == null) {
            return GuestUser();
          }
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
              USER user = snapshot.data.data();
              if (user == null) {
                return GuestUser();
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AccountInfoContainer(
                      user: user,
                    ),
                    PhoneNumberContainer(
                      user: user,
                    ),
                    NotificationSubscriptionContainer(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          await Provider.of<AuthenticationAPI>(context,
                                  listen: false)
                              .signOut();
                          Navigator.pop(context);
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(4.0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
