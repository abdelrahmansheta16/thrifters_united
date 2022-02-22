import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/AddressWidget.dart';
import 'package:thrifters_united/customUi/GuestUser.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../../../FirebaseAPI/OrderAPI.dart';
import '../../../customUi/AddressContainer.dart';
import 'AddAddress.dart';

class MyAddresses extends StatefulWidget {
  final USER user;
  MyAddresses({Key key, this.user}) : super(key: key);

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
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
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
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: widget.user == null
            ? GuestUser()
            : StreamBuilder<QuerySnapshot>(
                stream: UserAPI.loadAddresses(
                    FirebaseAuth.instance.currentUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Address> addresses =
                      snapshot.data.docs.map((DocumentSnapshot document) {
                    Address address;
                    address = document.data();
                    address.addressID = document.id;
                    return address;
                  }).toList();
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: AutoSizeText(
                            'MY ADDRESSES',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFFCFCFCF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        MyAddressContainer(addresses: addresses),
                        InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      AddAddress()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Icon(
                                    EvaIcons.plusCircle,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Text(
                                    'Add new address',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                )
                              ],
                            ),
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

class MyAddressContainer extends StatefulWidget {
  final List<Address> addresses;
  const MyAddressContainer({Key key, this.addresses}) : super(key: key);

  @override
  _MyAddressContainerState createState() => _MyAddressContainerState();
}

class _MyAddressContainerState extends State<MyAddressContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.addresses.map((address) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Consumer<OrderAPI>(
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12)),
                child: ListTile(
                  title: Text(
                    address.addressID,
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.streetName,
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        address.floorNumber,
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AddressAlertDialog(
                            address: address,
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        EvaIcons.trash2Outline,
                        color: Color(0xFF303030),
                        size: 25,
                      ),
                    ),
                  ),
                  tileColor: Color(0xFFF5F5F5),
                  dense: false,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
