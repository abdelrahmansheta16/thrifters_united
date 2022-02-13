import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/DioHelper.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/GuestUser.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Balance extends StatefulWidget {
  final User user;
  const Balance({Key key, this.user}) : super(key: key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'My Credit',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot<USER>>(
          future: UserAPI.getUser(widget.user.uid),
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
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.all(15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current balance: ',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'EGP ${user.credit.toStringAsFixed(2)}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '(USD ${(user.credit * DioHelper.convertRate).toStringAsFixed(2)})',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: 'Currently Unavailable');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.add_sharp,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Add Gift Card',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  // Widget _buildPopupDialog(BuildContext context) {
  //   return new CupertinoAlertDialog(
  //       title: const Text('Add Gift Card'),
  //       content: TextFormField(
  //         controller: textController,
  //         obscureText: false,
  //         decoration: InputDecoration(
  //           hintText: 'Enter your gift card code here',
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Colors.black,
  //               width: 1,
  //             ),
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(4.0),
  //               topRight: Radius.circular(4.0),
  //             ),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Colors.black,
  //               width: 1,
  //             ),
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(4.0),
  //               topRight: Radius.circular(4.0),
  //             ),
  //           ),
  //           suffixIcon: textController.text.isNotEmpty
  //               ? InkWell(
  //                   onTap: () => setState(
  //                     () => textController.clear(),
  //                   ),
  //                   child: Icon(
  //                     Icons.clear,
  //                     color: Color(0xFF757575),
  //                     size: 22,
  //                   ),
  //                 )
  //               : null,
  //         ),
  //         style: FlutterFlowTheme.bodyText1,
  //         textAlign: TextAlign.center,
  //         keyboardType: TextInputType.number,
  //         validator: (val) {
  //           if (val.isEmpty) {
  //             return 'Required';
  //           }
  //
  //           return null;
  //         },
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () async {
  //               if(formKey.currentState.validate()){
  //                 Navigator.pop(context);
  //               }
  //               await initConnectivity();
  //             },
  //             child: Text('Add')),
  //         TextButton(
  //             onPressed: ({bool animated}) async {
  //               await SystemChannels.platform
  //                   .invokeMethod<void>('SystemNavigator.pop', animated);
  //             },
  //             child: Text('Exit')),
  //       ]);
  // }
}
