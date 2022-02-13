import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Mainscreen.dart';
import 'package:thrifters_united/customUi/CartProductContainer.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/pages/Shopping/ChooseAddress.dart';
import 'package:thrifters_united/pages/Shopping/OrderConfirmation.dart';

class PlaceOrder extends StatefulWidget {
  final String userID;
  final String userRewardedID;
  final double userCredit;
  PlaceOrder({Key key, this.userID, this.userRewardedID, this.userCredit})
      : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool switchListTileValue = false;
  static List<String> Status = [
    'BeingProcessed',
    'OnItsWay',
    'Delivered',
    'Cancelled'
  ];
  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isAsyncCall,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.black),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            'Order',
            style: FlutterFlowTheme.subtitle1.override(
              fontFamily: 'Lexend Deca',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFF1F5F8),
        body: Consumer<OrderAPI>(
          builder: (context, value, child) {
            List<CartProductContainer> children =
                value.products?.map((product) {
                      return CartProductContainer(product: product);
                    })?.toList() ??
                    [];
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x4814181B),
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ITEMS',
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF8B97A2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            value.products?.length.toString(),
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF151B1E),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: children,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 0, 0),
                                    child: Text(
                                      'Shipping Address',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => chooseAddress(
                                          userID: widget.userID,
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      child: ListTile(
                                        title: Text(
                                          value.address.addressID,
                                          style:
                                              FlutterFlowTheme.title3.override(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.address.streetName,
                                              style: FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Text(
                                              value.address.floorNumber,
                                              style: FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF303030),
                                          size: 20,
                                        ),
                                        tileColor: Color(0xFFF5F5F5),
                                        dense: false,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          widget.userCredit > 0
                              ? Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: SwitchListTile(
                                      value: switchListTileValue,
                                      activeColor: Colors.teal,
                                      onChanged: (newValue) => setState(
                                          () => switchListTileValue = newValue),
                                      title: Text(
                                        'Apply your credit',
                                        style: FlutterFlowTheme.title3,
                                      ),
                                      tileColor: Color(0xFFF5F5F5),
                                      dense: false,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                )
                              : Container(),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width,
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //     ),
                          //     child: Column(
                          //       mainAxisSize: MainAxisSize.max,
                          //       crossAxisAlignment: CrossAxisAlignment.stretch,
                          //       children: [
                          //         Padding(
                          //           padding: EdgeInsetsDirectional.fromSTEB(
                          //               4, 0, 0, 0),
                          //           child: Text(
                          //             'Payment Method',
                          //             style:
                          //                 FlutterFlowTheme.bodyText1.override(
                          //               fontFamily: 'Poppins',
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.w600,
                          //             ),
                          //           ),
                          //         ),
                          //         ListTile(
                          //           title: Text(
                          //             value.method.toString(),
                          //             style: FlutterFlowTheme.title3.override(
                          //               fontFamily: 'Poppins',
                          //             ),
                          //           ),
                          //           trailing: Icon(
                          //             Icons.arrow_forward_ios,
                          //             color: Color(0xFF303030),
                          //             size: 20,
                          //           ),
                          //           tileColor: Color(0xFFF5F5F5),
                          //           dense: false,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x3A000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Consumer<OrderAPI>(
                                  builder: (context, model, child) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Summary',
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF090F13),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Subtotal',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF8B97A2),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            value
                                                .getSubtotal(value.products)
                                                .toString(),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF111417),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    model.isDiscountApplied
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 0, 16, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Discount',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.red,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  value
                                                      .discount(
                                                          value.getSubtotal(
                                                              value.products))
                                                      .toString(),
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tax',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF8B97A2),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            value
                                                .getTax(value.products)
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF111417),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shipping',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF8B97A2),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            '\$15',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF111417),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    switchListTileValue
                                        ? Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Credit',
                                                  style: FlutterFlowTheme
                                                      .bodyText2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF8B97A2),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  widget.userCredit >=
                                                          (value.getSubtotal(value.products) -
                                                              value.discount(
                                                                  value.getSubtotal(value
                                                                      .products)) +
                                                              value.getTax(value
                                                                  .products) +
                                                              15)
                                                      ? (value.getSubtotal(value.products) -
                                                              value.discount(
                                                                  value.getSubtotal(value
                                                                      .products)) +
                                                              value.getTax(value
                                                                  .products) +
                                                              15)
                                                          .toStringAsFixed(2)
                                                      : widget.userCredit
                                                          .toStringAsFixed(2),
                                                  textAlign: TextAlign.end,
                                                  style: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xFF111417),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 16, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF8B97A2),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            (value.getSubtotal(value.products) -
                                                    value.discount(value.getSubtotal(
                                                        value.products)) +
                                                    value.getTax(
                                                        value.products) +
                                                    15 -
                                                    (switchListTileValue
                                                        ? (widget.userCredit >=
                                                                (value.getSubtotal(value.products) -
                                                                    value.discount(value.getSubtotal(value
                                                                        .products)) +
                                                                    value.getTax(
                                                                        value
                                                                            .products) +
                                                                    15)
                                                            ? (value.getSubtotal(
                                                                    value.products) -
                                                                value.discount(value.getSubtotal(value.products)) +
                                                                value.getTax(value.products) +
                                                                15)
                                                            : widget.userCredit)
                                                        : 0))
                                                .toStringAsFixed(2),
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.subtitle1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF151B1E),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ),
                          ),
                          Divider(
                            height: 2,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.teal,
          elevation: 3,
          child: Consumer<OrderAPI>(
            builder: (context, value, child) {
              return Container(
                height: 50,
                child: FutureBuilder<DocumentSnapshot<USER>>(
                    future: UserAPI.getUser(widget.userID),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      USER user = snapshot.data.data();
                      return TextButton(
                        onPressed: () async {
                          setState(() {
                            isAsyncCall = true;
                          });
                          Order order = Order(
                            user: user,
                            shippingFee: 15,
                            status: Status[0],
                            orderedOn: DateTime.now(),
                            address: value.address,
                            products: value.products,
                            subtotal: value.getSubtotal(value.products),
                            tax: value.getTax(value.products),
                            discountApplied: value
                                .discount(value.getSubtotal(value.products)),
                            creditApplied: (switchListTileValue
                                ? (widget.userCredit >=
                                        (value.getSubtotal(value.products) -
                                            value.discount(value
                                                .getSubtotal(value.products)) +
                                            value.getTax(value.products) +
                                            15)
                                    ? (value.getSubtotal(value.products) -
                                        value.discount(
                                            value.getSubtotal(value.products)) +
                                        value.getTax(value.products) +
                                        15)
                                    : widget.userCredit)
                                : 0),
                            paymentMethod: value.method,
                            price: (value.getSubtotal(value.products) -
                                value.discount(
                                    value.getSubtotal(value.products)) +
                                value.getTax(value.products) +
                                15 -
                                (switchListTileValue
                                    ? (widget.userCredit >=
                                            (value.getSubtotal(value.products) -
                                                value.discount(
                                                    value.getSubtotal(
                                                        value.products)) +
                                                value.getTax(value.products) +
                                                15)
                                        ? (value.getSubtotal(value.products) -
                                            value.discount(value
                                                .getSubtotal(value.products)) +
                                            value.getTax(value.products) +
                                            15)
                                        : widget.userCredit)
                                    : 0)),
                          );
                          await value.addOrder(
                            currentOrder: order,
                            userID: widget.userID,
                            userRewardedID: widget.userRewardedID,
                            userCredit: (switchListTileValue
                                ? (widget.userCredit >=
                                        (value.getSubtotal(value.products) -
                                            value.discount(value
                                                .getSubtotal(value.products)) +
                                            value.getTax(value.products) +
                                            15)
                                    ? (value.getSubtotal(value.products) -
                                        value.discount(
                                            value.getSubtotal(value.products)) +
                                        value.getTax(value.products) +
                                        15)
                                    : widget.userCredit)
                                : 0),
                          );
                          final BottomNavigationBar navigationBar =
                              globalKey.currentWidget;
                          navigationBar.onTap(0);
                          setState(() {
                            isAsyncCall = false;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderConfirmation(),
                          ));
                        },
                        child: Text(
                          'Place Order',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
