// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:thrifters_united/models/Product.dart';

import '../utils.dart';
import 'Address.dart';

List<Order> productFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String productToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    this.orderID,
    this.address,
    this.products,
    this.shippingFee,
    this.status,
    this.paymentMethod,
    this.orderedOn,
    this.deliveredAt,
    this.price,
  });

  String orderID;
  Address address;
  List<dynamic> products;
  double shippingFee;
  Status status;
  PaymentMethod paymentMethod;
  DateTime orderedOn;
  DateTime deliveredAt;
  double price;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderID: json["orderID"],
        address: Address.fromJson(json["address"]),
        products: json["products"] != null
            ? List<dynamic>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : <Product>[],
        shippingFee: json["shippingFee"],
        status: Status.values
            .firstWhere((element) => element.toString() == json["status"]),
        paymentMethod: PaymentMethod.values.firstWhere(
            (element) => element.toString() == json["paymentMethod"]),
        orderedOn: Utils.toDateTime(json["orderedOn"]),
        deliveredAt: Utils.toDateTime(json["deliveredAt"]),
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "orderID": orderID,
        "address": address.toJson(),
        "products": products != null
            ? List<dynamic>.from(products.map((x) => x.toJson()))
            : <Product>[],
        "shippingFee": shippingFee,
        "status": status.toString(),
        "paymentMethod": paymentMethod.toString(),
        "orderedOn": Utils.fromDateTimeToJson(orderedOn),
        "deliveredAt": Utils.fromDateTimeToJson(deliveredAt),
        "price": price,
      };
}

enum Status { BeingProcessed, OnItsWay, Delivered }

enum PaymentMethod { CreditCard, Cash }
