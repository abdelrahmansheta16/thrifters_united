import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/models/Product.dart';
import 'package:thrifters_united/customUi/ProductDetails.dart';
import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final Product product;
  ProductContainer({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsWidget(
            product: product,
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment(1, -0.96),
                      child: Icon(
                        Icons.favorite_border_sharp,
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                product.title,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                product.productId,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                product.price.toString(),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
