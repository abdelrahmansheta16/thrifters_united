import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/models/Product.dart';

import 'ProductContainer.dart';

class ProductsGridView extends StatefulWidget {
  final List<Product> products;
  ProductsGridView({Key key, this.products}) : super(key: key);

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
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
          itemCount: widget.products.length.isEven
              ? widget.products.length
              : widget.products.length + 1,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index >= widget.products.length) {
              return Container(
                color: Colors.white,
              );
            }
            print('model.filteredProducts[index].productId');
            return ProductContainer(
              product: widget.products[index],
            );
          }),
    );
  }
}
