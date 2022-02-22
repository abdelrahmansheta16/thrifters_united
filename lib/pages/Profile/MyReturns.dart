import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/Screens/Homescreen.dart';
import 'package:thrifters_united/Screens/Mainscreen.dart';
import 'package:thrifters_united/customUi/CartProductContainer.dart';
import 'package:thrifters_united/customUi/OrderDetails.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../../FirebaseAPI/AuthenticationAPI.dart';
import '../../customUi/ProductDetails.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyReturn extends StatefulWidget {
  const MyReturn({Key key}) : super(key: key);

  @override
  _MyReturnState createState() => _MyReturnState();
}

class _MyReturnState extends State<MyReturn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Wishlist',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 1,
      ),
      body: Consumer<AuthenticationAPI>(builder: (context, model, child) {
        if (model.user == null) {
          return SignInWidget(
            currentScreen: 'wishlist',
          );
        }
        return FutureBuilder<DocumentSnapshot<USER>>(
            future: UserAPI.getUser(model.user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<Product> products = snapshot.data.data().returns;
              if (products.length == 0) {
                return NoReturns();
              }
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product currentProduct = products[index];
                    return OrderProducts(product: currentProduct);
                  });
            });
      }),
    );
  }
}

class NoReturns extends StatefulWidget {
  const NoReturns({Key key}) : super(key: key);

  @override
  _NoReturnsState createState() => _NoReturnsState();
}

class _NoReturnsState extends State<NoReturns> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Icon(
                  Icons.add_shopping_cart,
                  color: Color(0xFF6B6B6B),
                  size: 150,
                ),
              ),
              Text(
                'No Returns Yet !',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Looks like you have no returns yet',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF6B6B6B),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              FFButtonWidget(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Continue Shopping',
                options: FFButtonOptions(
                  width: 200,
                  height: 40,
                  color: Colors.black,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WishListProductContainer extends StatefulWidget {
  final Product product;
  const WishListProductContainer({Key key, this.product}) : super(key: key);

  @override
  _WishListProductContainerState createState() =>
      _WishListProductContainerState();
}

class _WishListProductContainerState extends State<WishListProductContainer> {
  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isAsyncCall,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: widget.product,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.black12)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.product.images[0],
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Container(
                      width: 100,
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.brand.name,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isAsyncCall = true;
                              });
                              await UserAPI.removeProductFromWishlist(
                                  product: widget.product);
                              setState(() {
                                isAsyncCall = false;
                              });
                            },
                            child: Icon(
                              Icons.close_sharp,
                              color: Color(0xFFC7C7C7),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.product.title,
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          children: widget.product.afterPrice ==
                                  widget.product.beforePrice
                              ? [
                                  Text(
                                    '${widget.product.afterPrice.toString()} EGP',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff51c0a9),
                                    ),
                                  ),
                                ]
                              : [
                                  Text(
                                    '${widget.product.beforePrice.toString()} EGP',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.black26,
                                      fontSize: 14,
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ]),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                isAsyncCall = true;
                              });
                              await UserAPI.addCart(
                                  product: widget.product,
                                  userID:
                                      FirebaseAuth.instance.currentUser.uid);
                              setState(() {
                                isAsyncCall = false;
                              });
                            },
                            text: 'Add To Cart',
                            options: FFButtonOptions(
                              width: 100,
                              height: 30,
                              color: Colors.white,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Roboto Condensed',
                                color: Color(0xFF03CE9F),
                                fontSize: 12,
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFF03CE9F),
                                width: 1,
                              ),
                              borderRadius: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WishlistWidget extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_outlined,
            color: Color(0xFFC9C9C9),
            size: 124,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Text(
              'Your wish list is empty.\nYou can save products that you like by tapping on the heart icon',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Color(0xFF808080),
                fontSize: 18,
              ),
            ),
          ),
          FFButtonWidget(
            onPressed: () {
              final BottomNavigationBar navigationBar = globalKey.currentWidget;
              navigationBar.onTap(0);
            },
            text: 'Go to Products',
            options: FFButtonOptions(
              width: 150,
              height: 30,
              color: Color(0xFF00BFA5),
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: 0,
            ),
          )
        ],
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  final String currentScreen;
  const SignInWidget({Key key, this.currentScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            currentScreen == 'wishlist'
                ? Icons.favorite_border_outlined
                : EvaIcons.shoppingBagOutline,
            color: Color(0xFFC9C9C9),
            size: 124,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentScreen == 'wishlist'
                  ? 'If you saved any items in your wishlist, you see them here after you login'
                  : 'You must login to add products to your cart',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Color(0xFF808080),
              ),
            ),
          ),
          FFButtonWidget(
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist/authentication');
            },
            text: 'SIGN IN',
            options: FFButtonOptions(
              width: 150,
              height: 30,
              color: Color(0xFF00BFA5),
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: 0,
            ),
          )
        ],
      ),
    );
  }
}
