import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/customUi/dialogBuilder.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/customUi/ProductDetails.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatefulWidget {
  final Product product;
  ProductContainer({Key key, this.product}) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
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
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationAPI>(builder: (context, model, child) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: widget.product,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.product.images.first,
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
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
                              color: Colors.black12,
                            ),
                          );
                        },
                      ),
                      model.user != null
                          ? Align(
                              alignment: Alignment.topRight,
                              child: StreamBuilder<QuerySnapshot<Product>>(
                                  stream: UserAPI.loadWishlist(model.user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    List<String> products = snapshot.data.docs
                                        .map((DocumentSnapshot document) {
                                      Product product;
                                      product = document.data();
                                      return product.productId;
                                    }).toList();
                                    return InkWell(
                                      onTap: () async {
                                        if (model.user != null) {
                                          if (products.contains(
                                              widget.product.productId)) {
                                            await UserAPI
                                                .removeProductFromWishlist(
                                                    product: widget.product);
                                          } else {
                                            await UserAPI.addWishlist(
                                                product: widget.product,
                                                userID: model.user.uid);
                                          }
                                        } else {
                                          setState(() {
                                            buildPopupDialog(context,
                                                'you must sign in first');
                                          });
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Material(
                                          elevation: 5,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Center(
                                              child: Icon(
                                                products.contains(widget
                                                        .product.productId)
                                                    ? Icons.favorite_sharp
                                                    : Icons
                                                        .favorite_border_sharp,
                                                color: Color(0xff51c0a9),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () async {
                                  buildPopupDialog(
                                      context, 'you must sign in first');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Center(
                                        child: Icon(
                                          Icons.favorite_border_sharp,
                                          color: Color(0xff51c0a9),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Text(
                  widget.product.title,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.product.productId ?? '',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                widget.product.afterPrice == widget.product.beforePrice
                    ? Text(
                        '${widget.product.afterPrice.toString()} EGP',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 16,
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
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            child: Text(
                              '${widget.product.afterPrice.toString()} EGP',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16,
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
        ),
      );
    });
  }
}
