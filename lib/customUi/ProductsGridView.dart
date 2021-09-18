import 'package:flutter/material.dart';
import 'package:thrifters_united/models/Product.dart';

import 'ProductContainer.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;

  ProductsGridView({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE1E1E1),
      ),
      child: GridView.builder(
          addRepaintBoundaries: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: products.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ProductContainer(
              product: products[index],
            );
          }),
    );
  }
}
