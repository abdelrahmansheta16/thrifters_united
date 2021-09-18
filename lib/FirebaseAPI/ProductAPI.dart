import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrifters_united/models/Product.dart';

import '../utils.dart';

class ProductAPI {
  static final ProductsRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
            toFirestore: (product, _) => product.toJson(),
          );

  static Stream<QuerySnapshot<Product>> loadProducts() {
    Stream<QuerySnapshot<Product>> products = ProductsRef.snapshots();
    return products;
  }

  static Future addProducts({Product product}) async {
    await ProductsRef.add(product);
  }
}
