import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/AddressContainer.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/pages/Profile/MyAddresses/AddAddress.dart';
import 'package:thrifters_united/pages/Shopping/ChoosePaymentMethod.dart';

import 'PlaceOrder.dart';

class chooseAddress extends StatefulWidget {
  final String userID;
  final String userRewardedID;
  final double userCredit;
  chooseAddress({Key key, this.userID, this.userRewardedID, this.userCredit})
      : super(key: key);

  @override
  _chooseAddressState createState() => _chooseAddressState();
}

class _chooseAddressState extends State<chooseAddress> {
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
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: UserAPI.loadAddresses(widget.userID),
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
                  // Divider(
                  //   height: 8,
                  //   thickness: 6,
                  //   color: Color(0xFFDDDDDD),
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //           ),
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Padding(
                  //                 padding: EdgeInsetsDirectional.fromSTEB(
                  //                     5, 5, 5, 5),
                  //                 child: Icon(
                  //                   Icons.settings_outlined,
                  //                   color: Colors.black,
                  //                   size: 24,
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsetsDirectional.fromSTEB(
                  //                     5, 5, 5, 5),
                  //                 child: Text(
                  //                   'Hello World',
                  //                   style: FlutterFlowTheme.bodyText1.override(
                  //                     fontFamily: 'Poppins',
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //           ),
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Padding(
                  //                 padding: EdgeInsetsDirectional.fromSTEB(
                  //                     5, 5, 5, 5),
                  //                 child: Icon(
                  //                   Icons.settings_outlined,
                  //                   color: Colors.black,
                  //                   size: 24,
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsetsDirectional.fromSTEB(
                  //                     5, 5, 5, 5),
                  //                 child: Text(
                  //                   'Hello World',
                  //                   style: FlutterFlowTheme.bodyText1.override(
                  //                     fontFamily: 'Poppins',
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Divider(
                    height: 3,
                    thickness: 3,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
                  AddressContainer(addresses: addresses),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => AddAddress()),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Icon(
                              EvaIcons.plusCircle,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        elevation: 3,
        child: Consumer<OrderAPI>(
          builder: (context, value, child) {
            return TextButton(
              onPressed: () {
                if (value.address.addressID != null) {
                  Provider.of<OrderAPI>(context, listen: false)
                      .addAddress(value.address);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => PlaceOrder(
                              userID: widget.userID,
                              userRewardedID: widget.userRewardedID,
                              userCredit: widget.userCredit,
                            )),
                  );
                } else {
                  Fluttertoast.showToast(msg: 'please choose an address');
                }
              },
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
