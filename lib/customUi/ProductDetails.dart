import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_drop_down_template.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dialogBuilder.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageViewController;

  // bool inWishlist;
  //
  // @override
  // void initState() {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     UserAPI.loadWishlist(FirebaseAuth.instance.currentUser.uid)
  //         .listen((event) {
  //       List<Product> products = event.docs.map((e) => e.data()).toList();
  //       if (products.contains(widget.product)) {
  //         inWishlist = true;
  //       } else {
  //         inWishlist = false;
  //       }
  //     });
  //   } else {
  //     inWishlist = false;
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          '${widget.product.title}',
          style: FlutterFlowTheme.subtitle1.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF151B1E),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Consumer<AuthenticationAPI>(builder: (context, model, child) {
            return model.user != null
                ? StreamBuilder<QuerySnapshot<Product>>(
                    stream: UserAPI.loadWishlist(model.user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      List<String> products =
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        Product product;
                        product = document.data();
                        return product.productId;
                      }).toList();
                      return InkWell(
                        onTap: () async {
                          if (model.user != null) {
                            if (products.contains(widget.product.productId)) {
                              await UserAPI.removeProductFromWishlist(
                                  product: widget.product);
                            } else {
                              await UserAPI.addWishlist(
                                  product: widget.product,
                                  userID: model.user.uid);
                            }
                          } else {
                            setState(() {
                              buildPopupDialog(
                                  context, 'you must sign in first');
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Icon(
                              products.contains(widget.product.productId)
                                  ? Icons.favorite_sharp
                                  : Icons.favorite_border_sharp,
                              color: Color(0xff51c0a9),
                              size: 35,
                            ),
                          ),
                        ),
                      );
                    })
                : InkWell(
                    onTap: () async {
                      buildPopupDialog(context, 'you must sign in first');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          Icons.favorite_border_sharp,
                          color: Color(0xff51c0a9),
                          size: 35,
                        ),
                      ),
                    ),
                  );
          }),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 90),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Stack(
                            children: [
                              PageView(
                                controller: pageViewController ??=
                                    PageController(initialPage: 0),
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    widget.product.images.length, (index) {
                                  return PinchZoom(
                                    child: Image.network(
                                      widget.product.images[index],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace stackTrace) {
                                        return Container(
                                          width: 100,
                                          height: 100,
                                        );
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                            color: Colors.black12,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: SmoothPageIndicator(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    count: widget.product.images.length,
                                    axisDirection: Axis.horizontal,
                                    onDotClicked: (i) {
                                      pageViewController.animateToPage(
                                        i,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    effect: ExpandingDotsEffect(
                                      expansionFactor: 2,
                                      spacing: 8,
                                      radius: 16,
                                      dotWidth: 16,
                                      dotHeight: 16,
                                      dotColor: Color(0xFF9E9E9E),
                                      activeDotColor: Color(0xff51c0a9),
                                      paintStyle: PaintingStyle.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.product.title,
                          style: FlutterFlowTheme.subtitle1.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF151B1E),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        widget.product.afterPrice == widget.product.beforePrice
                            ? Text(
                                '${widget.product.afterPrice.toString()} EGP',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff51c0a9),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${widget.product.beforePrice.toString()} EGP',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.black26,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, bottom: 4.0),
                                    child: Text(
                                      '${widget.product.afterPrice.toString()} EGP',
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Expanded(
                  //         child: AutoSizeText(
                  //           'A VINTAGE-LOOK JACKET CRAFTED FOR STYLE OFF THE FIELD.',
                  //           style: FlutterFlowTheme.subtitle2.override(
                  //             fontFamily: 'Lexend Deca',
                  //             color: Color(0xFF151B1E),
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w600,
                  //             fontStyle: FontStyle.italic,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.product.description}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 20),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       FlutterFlowDropDown(
                  //         initialOption: dropDownValue1 ??= 'Jacket Size',
                  //         options: [
                  //           'Jacket Size',
                  //           'Small',
                  //           'Medium',
                  //           'Large',
                  //           'X-Large'
                  //         ].toList(),
                  //         onChanged: (val) =>
                  //             setState(() => dropDownValue1 = val),
                  //         width: MediaQuery.of(context).size.width * 0.42,
                  //         height: 50,
                  //         textStyle: FlutterFlowTheme.bodyText1.override(
                  //           fontFamily: 'Lexend Deca',
                  //           color: Colors.black,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.normal,
                  //         ),
                  //         fillColor: Colors.white,
                  //         elevation: 2,
                  //         borderColor: Color(0xFFE1E3E5),
                  //         borderWidth: 2,
                  //         borderRadius: 8,
                  //         margin: EdgeInsetsDirectional.fromSTEB(12, 4, 8, 4),
                  //         hidesUnderline: true,
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  //         child: FlutterFlowDropDown(
                  //           initialOption: dropDownValue2 ??= 'Jacket Color',
                  //           options: ['Jacket Color', 'White', 'Black', 'Tan']
                  //               .toList(),
                  //           onChanged: (val) =>
                  //               setState(() => dropDownValue2 = val),
                  //           width: MediaQuery.of(context).size.width * 0.42,
                  //           height: 50,
                  //           textStyle: FlutterFlowTheme.bodyText1.override(
                  //             fontFamily: 'Lexend Deca',
                  //             color: Colors.black,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.normal,
                  //           ),
                  //           fillColor: Colors.white,
                  //           elevation: 2,
                  //           borderColor: Color(0xFFE1E3E5),
                  //           borderWidth: 2,
                  //           borderRadius: 8,
                  //           margin: EdgeInsetsDirectional.fromSTEB(12, 4, 8, 4),
                  //           hidesUnderline: true,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            'Info and Care',
                            style: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF151B1E),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 6, 20, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'Size',
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        '${widget.product.size.name}',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF8B97A2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'Color',
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          '${widget.product.color.isEmpty ? '' : widget.product.color.first}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF8B97A2),
                                          ),
                                        )),
                                  ),
                                ],
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
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xFF090F13),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x2D000000),
                        offset: Offset(0, -2),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (FirebaseAuth.instance.currentUser == null) {
                          setState(() {
                            buildPopupDialog(context, 'you must sign in first');
                          });
                        } else {
                          UserAPI.addCart(
                              product: widget.product,
                              userID: FirebaseAuth.instance.currentUser.uid);
                          Navigator.pop(context);
                        }
                      },
                      text: 'Add to Cart',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: Color(0xFF090F13),
                        textStyle: FlutterFlowTheme.subtitle1.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 0,
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
  }
}
