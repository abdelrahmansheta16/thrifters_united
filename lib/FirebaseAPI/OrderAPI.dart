import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderAPI with ChangeNotifier {
  List<Product> products = [];
  Address address = new Address();
  String method;
  double Price;
  bool isDiscountApplied = false;
  final adminOrdersRef =
      FirebaseFirestore.instance.collection('orders').withConverter<Order>(
            fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
            toFirestore: (order, _) => order.toJson(),
          );

  void addAddress(Address value) {
    if (address == null) {
      address = value;
    }
    notifyListeners();
  }

  void addProducts(List<Product> value) {
    products?.clear();
    products?.addAll(value);
    Price = 0;
    value.forEach((product) {
      Price += product.afterPrice;
    });
    notifyListeners();
  }

  void addPaymentMethod(String value) {
    method = value;
    notifyListeners();
  }

  double getSubtotal(List<Product> products) {
    double subtotal = 0;
    products?.forEach((product) {
      subtotal += product.afterPrice;
    });
    return subtotal;
  }

  double getTax(List<Product> products) {
    double tax = 0;
    tax = getSubtotal(products) * 0.14;
    return tax;
  }
  // double getCredit(double userCredit){
  //
  // }
  // double totalPrice() {
  //   double totalPrice = 0;
  //   totalPrice = getSubtotal(products) -
  //       discount(getSubtotal(products)) +
  //       getTax(products) +
  //       15;
  //   Price = totalPrice;
  //   return totalPrice;
  // }

  double discount(double subtotal) {
    double discount = 0;
    if (isDiscountApplied) {
      discount = subtotal * 0.25;
      if (discount > 100) {
        return 100;
      }
      return discount;
    }
    return discount;
  }

  Future addOrder(
      {Order currentOrder, String userID, String userRewardedID, double userCredit}) async {
    final OrdersRef = FirebaseFirestore.instance
        .collection('users/$userID/orders')
        .withConverter<Order>(
          fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
          toFirestore: (order, _) => order.toJson(),
        );
    final UsersRef =
        FirebaseFirestore.instance.collection('users').withConverter<USER>(
              fromFirestore: (snapshot, _) => USER.fromJson(snapshot.data()),
              toFirestore: (user, _) => user.toJson(),
            );
    USER currentUser =
        await UsersRef.doc(userID).get().then((value) => value.data());
    await OrdersRef.add(currentOrder).then((value) {
      currentOrder.orderID = value.id;
      OrdersRef.doc(value.id).set(currentOrder);
      adminOrdersRef.doc(value.id).set(currentOrder);
      return null;
    }).whenComplete(() {
      if (isDiscountApplied) {
        UserAPI.getUser(userRewardedID).then((value) {
          double newCredit = value.data().credit +100;
          FirebaseFirestore.instance
              .collection('users')
              .doc(userRewardedID)
              .update({
            'credit': newCredit,
            'rewardUsed': true,
          });
        });
      }
    });
    isDiscountApplied = false;
   await UserAPI.getUser(userID).then((value) {
      double newCredit = value.data().credit -userCredit;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .update({
        'credit': newCredit,
      });
    });
    await sendEmail(currentUser.email, currentUser.name, currentOrder.orderID);
    await UserAPI.clearCart();
  }

  static Stream<QuerySnapshot> loadOrders({String userID}) {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/orders')
        .withConverter<Order>(
          fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()),
          toFirestore: (order, _) => order.toJson(),
        );
    Stream<QuerySnapshot<Order>> orders = UsersRef.snapshots();
    return orders;
  }

  sendEmail(String email, String name, String orderID) async {
    final serviceId = 'service_sbqpi58';
    final templateId = 'template_572gn89';
    final userId = 'user_ZapG5NvzvcwRkJdGw95KC';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'order_id': orderID,
          'message': '<h1>hello<h1>\n'
        }
      }),
    );
    print(response.body);
  }
}
