import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../utils.dart';

class ProductAPI {
  static final ProductsRef =
      FirebaseFirestore.instance.collection('products').withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
            toFirestore: (product, _) => product.toJson(),
          );
  static final CategoryRef = FirebaseFirestore.instance
      .collection('categories')
      .withConverter<Category>(
        fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()),
        toFirestore: (category, _) => category.toJson(),
      );

  static Stream<QuerySnapshot<Product>> loadProducts() {
    Stream<QuerySnapshot<Product>> products = ProductsRef.snapshots();
    return products;
  }

  static Future addProduct({Product product}) async {
    // List<Category> categories = product.categories;
    // List<String> names = categories.map((e) => e.name).toList();
    // Category category = await CategoryRef.doc('women').get().then((value) {
    //   return value.data();
    // });
    //
    // category = searchCategory(category, product, names);
    // CategoryRef.doc('women').set(category);
    // // CategoryRef.get().then((value) {
    // //   value.docs.map((DocumentSnapshot document) {
    // //     Category category;
    // //     category = document.data();
    // //     Product product;
    // //     searchCategory(category, product, names);
    // //   });
    // // });
    await ProductsRef.add(product);
  }

  // static Future addProductToWishlist({Product product}) async {
  //   product.inWishList = true;
  //   await ProductsRef.doc(product.productId).set(product);
  // }
  //
  // static Future removeProductToWishlist({Product product}) async {
  //   product.inWishList = false;
  //   await ProductsRef.doc(product.productId).set(product);
  // }

  static Future addCategory(
      {@required Category category, String categoryName}) async {
    CategoryRef.doc(categoryName).set(category);
  }

  static Stream<QuerySnapshot<Category>> loadCategories() {
    return CategoryRef.snapshots();
  }

  // static Category searchCategory(
  //     Category category, Product product, List<String> names) {
  //   if (names.contains(category.name)) {
  //     String name =
  //         names.where((element) => names.contains(category.name)).toString();
  //     category.products.add(product);
  //   }
  //   category.subCategories.forEach((first) {
  //     if (names.contains(first.name)) {
  //       first.products.add(product);
  //     }
  //     if (first.subCategories.length != 0) {
  //       first.subCategories.forEach((element) {
  //         searchCategory(element, product, names);
  //       });
  //     }
  //   });
  //   return category;
  // }
}
