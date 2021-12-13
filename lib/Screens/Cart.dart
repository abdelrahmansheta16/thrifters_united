import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Wishlist.dart';
import 'package:thrifters_united/customUi/CartProductContainer.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/pages/Shopping/ChooseAddress.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // String userID;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   userID = FirebaseAuth.instance.currentUser.uid;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF151B1E),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF1F5F8),
      body: Consumer<AuthenticationAPI>(builder: (context, model, child) {
        return SafeArea(
          child: model.user == null
              ? SignInWidget()
              : StreamBuilder<QuerySnapshot>(
                  stream:
                      UserAPI.loadCart(FirebaseAuth.instance.currentUser.uid),
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
                              padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Total',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.docs.length.toString(),
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
                            padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.96,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x3A000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 0,
                                          ),
                                        ),
                                        child: Column(
                                          children: snapshot.data.docs
                                              .map((DocumentSnapshot document) {
                                            Product product = document.data();
                                            return CartProductContainer(
                                                product: product);
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.96,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16, 16, 16, 12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Order Summary',
                                                style: FlutterFlowTheme
                                                    .subtitle2
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
                                          padding:
                                              EdgeInsets.fromLTRB(16, 0, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF8B97A2),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                UserAPI.subtotal(snapshot
                                                        .data.docs
                                                        .map((product) =>
                                                            product.data())
                                                        .toList())
                                                    .toString(),
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
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 0, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Tax',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF8B97A2),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                UserAPI.tax(snapshot.data.docs
                                                        .map((product) =>
                                                            product.data())
                                                        .toList())
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
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16, 0, 16, 12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Shipping',
                                                style: FlutterFlowTheme
                                                    .bodyText2
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
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16, 12, 16, 16),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total',
                                                style: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF8B97A2),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                (UserAPI.subtotal(snapshot
                                                            .data.docs
                                                            .map((product) =>
                                                                product.data())
                                                            .toList()) +
                                                        UserAPI.tax(snapshot
                                                            .data.docs
                                                            .map((product) =>
                                                                product.data())
                                                            .toList()) +
                                                        15)
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: FlutterFlowTheme
                                                    .subtitle1
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
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  thickness: 1,
                                  indent: 16,
                                  endIndent: 16,
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 16, 0, 16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/images/applePay.png',
                                          width: 160,
                                          height: 44,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/payPal.png',
                                        width: 160,
                                        height: 44,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    List<Product> products = snapshot.data.docs
                                        .map((DocumentSnapshot document) {
                                      Product product;
                                      product = document.data();
                                      product.productId = document.id;
                                      return product;
                                    }).toList();
                                    Provider.of<OrderAPI>(context,
                                            listen: false)
                                        .addProducts(products);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => chooseAddress(
                                                userID: FirebaseAuth
                                                    .instance.currentUser.uid,
                                              )),
                                    );
                                  },
                                  text: 'Proceed to Checkout',
                                  options: FFButtonOptions(
                                    width: 320,
                                    height: 60,
                                    color: Color(0xFF03CE9F),
                                    textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 8,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        );
      }),
    );
  }
}
