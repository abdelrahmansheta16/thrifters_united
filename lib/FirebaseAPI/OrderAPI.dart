import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/models/Address.dart';
import 'package:thrifters_united/models/Order.dart';
import 'package:thrifters_united/models/Product.dart';

class OrderAPI with ChangeNotifier {
  List<Product> products = [];
  Address address = new Address();
  PaymentMethod method;
  double Price;

  void addAddress(Address value) {
    if (address == null) {
      address = value;
    }
    notifyListeners();
  }

  void addProducts(List<Product> value) {
    products?.clear();
    products?.addAll(value);
    notifyListeners();
  }

  void addPaymentMethod(PaymentMethod value) {
    method = value;
    notifyListeners();
  }

  double getSubtotal(List<Product> products) {
    double subtotal = 0;
    products?.forEach((product) {
      subtotal += product.price;
    });
    return subtotal;
  }

  double getTax(List<Product> products) {
    double tax = 0;
    tax = getSubtotal(products) * 0.14;
    return tax;
  }

  double totalPrice(List<Product> products) {
    double totalPrice = 0;
    totalPrice = getSubtotal(products) + getTax(products) + 15;
    Price = totalPrice;
    return totalPrice;
  }

  Future addOrder({Order currentOrder, String userID}) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/orders')
        .withConverter<Order>(
          fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
          toFirestore: (order, _) => order.toJson(),
        );
    await UsersRef.add(
      Order(
        address: currentOrder.address,
        products: currentOrder.products,
        paymentMethod: currentOrder.paymentMethod,
        price: Price,
      ),
    );
  }
}
