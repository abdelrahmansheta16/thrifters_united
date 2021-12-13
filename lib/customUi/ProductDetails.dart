import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'dialogBuilder.dart';

class ProductDetailsWidget extends StatefulWidget {
  final Product product;

  ProductDetailsWidget({Key key, @required this.product}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  final pageViewController = PageController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Color(0xFF262D34),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            ;
          },
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Color(0xFF95A1AC),
            size: 30,
          ),
          iconSize: 30,
        ),
        title: Text(
          'Back to Products',
          style: FlutterFlowTheme.bodyText2.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF8B97A2),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('IconButton pressed ...');
            },
            icon: Icon(
              Icons.favorite_border_sharp,
              color: Colors.white,
              size: 30,
            ),
            iconSize: 30,
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF262D34),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Color(0x3E000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                            child: PageView(
                                controller: pageViewController,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    widget.product.images.length, (index) {
                                  return Image.network(
                                    widget.product.images[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  );
                                })
                                // [
                                //   Image.network(
                                //     widget.product.images[0],
                                //     width: 100,
                                //     height: 100,
                                //     fit: BoxFit.cover,
                                //   ),
                                //   Image.network(
                                //     widget.product.images[1],
                                //     width: 100,
                                //     height: 100,
                                //     fit: BoxFit.cover,
                                //   ),
                                //   Image.network(
                                //     widget.product.images[2],
                                //     width: 100,
                                //     height: 100,
                                //     fit: BoxFit.cover,
                                //   )
                                // ],
                                ),
                          ),
                          Align(
                            alignment: Alignment(0, 1),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: SmoothPageIndicator(
                                controller: pageViewController,
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
                                  activeDotColor: Color(0xFF3F51B5),
                                  paintStyle: PaintingStyle.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.productId,
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.title,
                    style: FlutterFlowTheme.bodyText2.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF8B97A2),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    '\$' + widget.product.price.toString(),
                    textAlign: TextAlign.end,
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF39D2C0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.description,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: FFButtonWidget(
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser == null) {
                    setState(() {
                      showDialog(
                        useRootNavigator: false,
                        useSafeArea: false,
                        context: context,
                        builder: (BuildContext context) =>
                            buildPopupDialog(context, 'you must sign in first'),
                      );
                    });
                  }

                  await UserAPI.addCart(
                      product: widget.product,
                      userID: FirebaseAuth.instance.currentUser.uid);
                  Navigator.pop(context);
                },
                text: 'Add to Cart',
                options: FFButtonOptions(
                  width: 170,
                  height: 50,
                  color: Color(0xFF39D2C0),
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
            )
          ],
        ),
      ),
    );
  }
}
