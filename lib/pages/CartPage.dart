import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Wishlist.dart';
import 'package:thrifters_united/customUi/CartProductContainer.dart';
import 'package:thrifters_united/customUi/EmptyCart.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/pages/Shopping/ChooseAddress.dart';

class CartPage extends StatefulWidget {
  final List<Product> products;
  CartPage({Key key, this.products}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  // bool isDiscountApplied = false;
  Color submitColor = Colors.black12;

  String userRewardedID;

  double userCredit;

  String rewards;
  // String userID;

  @override
  void initState() {
    textController = TextEditingController();
    UserAPI.getUser(FirebaseAuth.instance.currentUser.uid).then((value) {
      userCredit = value.data().credit;
      rewards = value.data().rewards;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Consumer<FilterProvider>(builder: (context, users, child) {
        return widget.products.isEmpty
            ? EmptyCart()
            : SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              widget.products.length.toString(),
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
                                      MediaQuery.of(context).size.width * 0.96,
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
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                  ),
                                  child: Column(
                                    children: List.generate(
                                        widget.products.length, (index) {
                                      Product product = widget.products[index];
                                      return CartProductContainer(
                                          product: product);
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
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
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Save on your order',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Consumer<OrderAPI>(
                                        builder: (context, model, child) {
                                      return Form(
                                        key: formKey,
                                        child: TextFormField(
                                          controller: textController,
                                          obscureText: false,
                                          onChanged: (text) {
                                            if (text.length != 0) {
                                              setState(() {
                                                submitColor = Color(0xFF03CE9F);
                                              });
                                            } else {
                                              setState(() {
                                                submitColor = Colors.black12;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Enter voucher code here',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFECECEC),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFECECEC),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.credit_card,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: TextButton(
                                              onPressed: () {
                                                model.isDiscountApplied = false;
                                                print(textController.text);
                                                if (formKey.currentState
                                                    .validate()) {
                                                  setState(() {
                                                    showSpinner = true;
                                                  });
                                                  users.users
                                                      .forEach((element) {
                                                    if (element.rewards ==
                                                        textController.text) {
                                                      if (rewards !=
                                                          element.rewards) {
                                                        if (!element
                                                            .rewardUsed) {
                                                          setState(() {
                                                            model.isDiscountApplied =
                                                                true;
                                                            userRewardedID =
                                                                element.userID;
                                                          });
                                                        }
                                                      }
                                                    }
                                                  });
                                                  Future.delayed(
                                                      Duration(seconds: 1), () {
                                                    setState(() {
                                                      if (!model
                                                          .isDiscountApplied) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Invalid code');
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'discount applied');
                                                      }
                                                      showSpinner = false;
                                                      textController.clear();
                                                    });
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Submit',
                                                style: TextStyle(
                                                    color: submitColor),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.text,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'Required';
                                            }

                                            return null;
                                          },
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.96,
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
                                      padding:
                                          EdgeInsets.fromLTRB(16, 16, 16, 12),
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
                                      padding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                                            model
                                                .getSubtotal(widget.products)
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
                                                  model
                                                      .discount(
                                                          model.getSubtotal(
                                                              widget.products))
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
                                      padding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                                            model
                                                .getTax(widget.products)
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
                                      padding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 12, 16, 16),
                                      child: Consumer<OrderAPI>(
                                          builder: (context, model, child) {
                                        return Row(
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
                                              (model.getSubtotal(
                                                          widget.products) -
                                                      model.discount(model
                                                          .getSubtotal(widget
                                                              .products)) +
                                                      model.getTax(
                                                          widget.products) +
                                                      15)
                                                  .toString(),
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
                                        );
                                      }),
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
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
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
                              Provider.of<OrderAPI>(context, listen: false)
                                  .addProducts(widget.products);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => chooseAddress(
                                          userID: FirebaseAuth
                                              .instance.currentUser.uid,
                                          userRewardedID: userRewardedID,
                                          userCredit: userCredit,
                                        )),
                              );
                            },
                            text: 'Proceed to Checkout',
                            options: FFButtonOptions(
                              width: 320,
                              height: 60,
                              color: Color(0xFF03CE9F),
                              textStyle: FlutterFlowTheme.subtitle2.override(
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
  }

  // double discount(double subtotal) {
  //   double discount = 0;
  //   if (isDiscountApplied) {
  //     discount = subtotal * 0.25;
  //     if (discount > 100) {
  //       return 100;
  //     }
  //     return discount;
  //   }
  //   return discount;
  // }
}
