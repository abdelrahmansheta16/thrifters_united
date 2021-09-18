// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:thrifters_united/models/Address.dart';
import 'package:thrifters_united/models/Order.dart';
import 'package:thrifters_united/models/Product.dart';

import '../utils.dart';

List<USER> productFromJson(String str) =>
    List<USER>.from(json.decode(str).map((x) => USER.fromJson(x)));

String productToJson(List<USER> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class USER {
  USER({
    this.userID,
    this.name,
    this.gender,
    this.phoneNumber,
    this.email,
    this.password,
    this.preferredStore,
    this.myBrands,
    this.cart,
    this.subscribed,
    this.rewards,
    this.orders,
    this.returns,
    this.credit,
    this.birthday,
    this.addresses,
    this.cards,
  });

  String userID;
  String name;
  String phoneNumber;
  String email;
  String myBrands;
  String password;
  bool subscribed;
  String rewards;
  List<Product> cart;
  List<Order> returns;
  Gender gender;
  PreferredStore preferredStore;
  List<Order> orders;
  double credit;
  DateTime birthday;
  List<Address> addresses;
  double cards;

  factory USER.fromJson(Map<String, dynamic> json) => USER(
        userID: json["userID"],
        gender: json["gender"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        password: json["password"],
        myBrands: json["myBrands"],
        subscribed: json["subscribed"],
        preferredStore: json["preferredStore"],
        rewards: json["rewards"],
        cart: json["cart"] != null
            ? List<Product>.from(json["cart"].map((x) => Product.fromJson(x)))
            : <Product>[],
        orders: json["orders"] != null
            ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
            : <Order>[],
        returns: json["returns"] != null
            ? List<Order>.from(json["returns"].map((x) => Order.fromJson(x)))
            : <Order>[],
        credit: json["credit"] != null ? json["credit"].toDouble() : null,
        birthday: Utils.toDateTime(json["birthday"]),
        addresses: json["addresses"] != null
            ? List<Address>.from(
                json["addresses"].map((x) => Address.fromJson(x)))
            : <Address>[],
        cards: json["cards"] != null ? json["cards"].toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "subscribed": subscribed,
        "email": email,
        "password": password,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "name": name,
        "preferredStore": preferredStore,
        "myBrands": myBrands,
        "rewards": rewards,
        "cards": cards,
        "cart": cart != null
            ? List<dynamic>.from(cart.map((x) => x.toJson()))
            : <Product>[],
        "orders": orders != null
            ? List<dynamic>.from(orders.map((x) => x.toJson()))
            : <Order>[],
        "returns": returns != null
            ? List<dynamic>.from(returns.map((x) => x.toJson()))
            : <Order>[],
        "credit": credit,
        "birthday": Utils.fromDateTimeToJson(birthday),
        "addresses": addresses != null
            ? List<dynamic>.from(addresses.map((x) => x.toJson()))
            : <Address>[],
      };
}

enum PreferredStore { Women, Men, Kids, Brands }

enum Gender { Male, Female }
