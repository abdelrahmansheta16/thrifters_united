// // To parse this JSON data, do
// //
// //     final product = productFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:thrifters_united/models/Product.dart';
//
// import '../utils.dart';
// import 'Address.dart';
// import 'User.dart';
//
// List<Order> productFromJson(String str) =>
//     List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));
//
// String productToJson(List<Order> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Order {
//   Order({
//     this.orderID,
//     this.user,
//     this.address,
//     this.products,
//     this.shippingFee,
//     this.status,
//     this.paymentMethod,
//     this.orderedOn,
//     this.deliveredAt,
//     this.price,
//   });
//
//   String orderID;
//   USER user;
//   Address address;
//   List<dynamic> products;
//   double shippingFee;
//   String status;
//   String paymentMethod;
//   DateTime orderedOn;
//   DateTime deliveredAt;
//   double price;
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         orderID: json["orderID"],
//         user: USER.fromJson(json["user"]),
//         address: Address.fromJson(json["address"]),
//         products: json["products"] != null
//             ? List<dynamic>.from(
//                 json["products"].map((x) => Product.fromJson(x)))
//             : <Product>[],
//         shippingFee: json["shippingFee"],
//         status: json["status"],
//         paymentMethod: json["paymentMethod"].toString(),
//         orderedOn: Utils.toDateTime(json["orderedOn"]),
//         deliveredAt: Utils.toDateTime(json["deliveredAt"]),
//         price: json["price"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "orderID": orderID,
//         "user": user.toJson(),
//         "address": address.toJson(),
//         "products": products != null
//             ? List<dynamic>.from(products.map((x) => x.toJson()))
//             : <Product>[],
//         "shippingFee": shippingFee,
//         "status": status,
//         "paymentMethod": paymentMethod,
//         "orderedOn": Utils.fromDateTimeToJson(orderedOn),
//         "deliveredAt": Utils.fromDateTimeToJson(deliveredAt),
//         "price": price,
//       };
// }
