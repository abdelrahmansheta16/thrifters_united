import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/AddressWidget.dart';
import 'package:thrifters_united/customUi/GuestUser.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/models/Address.dart';

class MyAddresses extends StatefulWidget {
  final String userID;
  MyAddresses({Key key, this.userID}) : super(key: key);

  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
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
          'Addresses',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                widget.userID == null
                    ? null
                    : await UserAPI.addAddresses(
                        UserAPI.address, widget.userID);
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.black,
                ),
              ))
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: widget.userID == null
            ? GuestUser()
            : StreamBuilder<QuerySnapshot>(
                stream: UserAPI.loadAddresses(widget.userID),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        Address address;
                        address = document.data();
                        address.AddressID = document.id;
                        return AddressWidget(address: address);
                      }).toList(),
                    ),
                  );
                }),
      ),
    );
  }
}
