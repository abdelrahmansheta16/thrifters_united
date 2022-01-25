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
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationAPI>(builder: (context, model, child) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsWidget(
              product: widget.product,
            ),
          ));
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.product.images[0],
                        fit: BoxFit.cover,
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            color: Colors.white,
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: IconButton(
                                    iconSize: 25,
                                    onPressed: () async {
                                      if (model.user != null) {
                                        if (widget.product.inWishList) {
                                          await UserAPI
                                              .removeProductFromWishlist(
                                                  product: widget.product);
                                          setState(() {});
                                        } else {
                                          await UserAPI.addWishlist(
                                              product: widget.product,
                                              userID: model.user.uid);
                                          setState(() {});
                                        }
                                      } else {
                                        buildPopupDialog(
                                            context, 'you must sign in first');
                                      }
                                    },
                                    icon: Icon(
                                      widget.product.inWishList
                                          ? Icons.favorite_sharp
                                          : Icons.favorite_border_sharp,
                                      color: Color(0xff51c0a9),
                                    )),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Text(
                  widget.product.title,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  widget.product.productId ?? '',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  widget.product.price.toString(),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
