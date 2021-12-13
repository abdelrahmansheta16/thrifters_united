import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import 'ProductAPI.dart';

class UserAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Stream<QuerySnapshot<USER>> loadUsers() {
    final UsersRef =
        FirebaseFirestore.instance.collection('users').withConverter<USER>(
              fromFirestore: (snapshot, _) => USER.fromJson(snapshot.data()),
              toFirestore: (user, _) => user.toJson(),
            );
    Stream<QuerySnapshot<USER>> users = UsersRef.snapshots();
    return users;
  }

  static Future<DocumentSnapshot<USER>> getUser(String userID) {
    final UsersRef =
        FirebaseFirestore.instance.collection('users').withConverter<USER>(
              fromFirestore: (snapshot, _) => USER.fromJson(snapshot.data()),
              toFirestore: (user, _) => user.toJson(),
            );
    Future<DocumentSnapshot<USER>> users = UsersRef.doc(userID).get();
    return users;
  }

  static Stream<QuerySnapshot<Product>> loadCart(String userID) {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/cart')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    Stream<QuerySnapshot<Product>> cart = UsersRef.snapshots();
    return cart;
  }

  static Stream<QuerySnapshot<Product>> loadWishlist(String userID) {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/wishlist')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    Stream<QuerySnapshot<Product>> wishlist = UsersRef.snapshots();
    return wishlist;
  }

  static Future setUser({USER user}) async {
    final UsersRef =
        FirebaseFirestore.instance.collection('users').withConverter<USER>(
              fromFirestore: (snapshot, _) => USER.fromJson(snapshot.data()),
              toFirestore: (user, _) => user.toJson(),
            );

    await UsersRef.doc(user.userID).set(user, SetOptions(merge: true));
  }

  static Future addCart({Product product, String userID}) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/cart')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    await UsersRef.doc(product.productId).set(product);
  }

  static Future addWishlist({Product product, String userID}) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/wishlist')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    await UsersRef.doc(product.productId).set(product);
    await ProductAPI.addProductToWishlist(product: product);
  }

  static Future removeProductFromCart({Product product}) async {
    String userID = await auth.currentUser.uid;
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/cart')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    UsersRef.doc(product.productId).delete();
  }

  static Future removeProductFromWishlist({Product product}) async {
    String userID = await auth.currentUser.uid;
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/wishlist')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    UsersRef.doc(product.productId).delete();
    await ProductAPI.removeProductToWishlist(product: product);
  }

  static Future clearCart() async {
    String userID = await auth.currentUser.uid;
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/cart')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    UsersRef.get().then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      },
    );
  }

  static Future<List<QueryDocumentSnapshot>> checkout(String userID) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/cart')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()),
          toFirestore: (product, _) => product.toJson(),
        );
    List<QueryDocumentSnapshot<Product>> cart =
        await UsersRef.get().then((product) => product.docs);
    return cart;
  }

  static double subtotal(List<dynamic> products) {
    double currentPrice = 0;
    products.forEach((product) {
      currentPrice += product.price;
    });
    return currentPrice;
  }

  static double tax(List<dynamic> products) {
    double currentPrice = 0;
    products.forEach((product) {
      currentPrice += product.price;
    });
    return currentPrice * 0.14;
  }

  static Stream<QuerySnapshot<Address>> loadAddresses(String userID) {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/addresses')
        .withConverter<Address>(
          fromFirestore: (snapshot, _) => Address.fromJson(snapshot.data()),
          toFirestore: (address, _) => address.toJson(),
        );
    Stream<QuerySnapshot<Address>> cart = UsersRef.snapshots();
    return cart;
  }

  static Future removeAddress({Address address}) async {
    String userID = await auth.currentUser.uid;
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/addresses')
        .withConverter<Address>(
          fromFirestore: (snapshot, _) => Address.fromJson(snapshot.data()),
          toFirestore: (address, _) => address.toJson(),
        );
    UsersRef.doc(address.addressID).delete();
  }
}
