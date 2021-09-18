// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import '../utils.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.productId,
    this.title,
    this.images,
    this.description,
    this.category,
    this.brand,
    this.color,
    this.type,
    this.size,
    this.isLowQuantity,
    this.isSoldOut,
    this.isBackorder,
    this.isVisible,
    this.publishedAt,
    this.updatedAt,
    this.price,
    this.inventoryManagement,
    this.inventoryPolicy,
    this.taxable,
  });

  String productId;
  String title;
  List<String> images;
  String description;
  String category;
  String brand;
  List<String> color;
  String type;
  List<String> size;
  bool isLowQuantity;
  bool isSoldOut;
  bool isBackorder;
  bool isVisible;
  DateTime publishedAt;
  DateTime updatedAt;
  double price;
  bool inventoryManagement;
  bool inventoryPolicy;
  bool taxable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productID"],
        title: json["title"],
        images: List<String>.from(json["images"].map((x) => x)),
        description: json["description"],
        category: json["category"],
        brand: json["brand"],
        color: List<String>.from(json["color"].map((x) => x)),
        type: json["type"],
        size: List<String>.from(json["size"].map((x) => x)),
        isLowQuantity: json["isLowQuantity"],
        isSoldOut: json["isSoldOut"],
        isBackorder: json["isBackorder"],
        isVisible: json["isVisible"],
        publishedAt: Utils.toDateTime(json["publishedAt"]),
        updatedAt: Utils.toDateTime(json["updatedAt"]),
        price: json["price"].toDouble(),
        inventoryManagement: json["inventoryManagement"],
        inventoryPolicy: json["inventoryPolicy"],
        taxable: json["taxable"],
      );

  Map<String, dynamic> toJson() => {
        "productID": productId,
        "title": title,
        "images": List<String>.from(images.map((x) => x)),
        "description": description,
        "category": category,
        "brand": brand,
        "color": List<String>.from(color.map((x) => x)),
        "type": type,
        "size": List<String>.from(size.map((x) => x)),
        "isLowQuantity": isLowQuantity,
        "isSoldOut": isSoldOut,
        "isBackorder": isBackorder,
        "isVisible": isVisible,
        "publishedAt": Utils.fromDateTimeToJson(publishedAt),
        "updatedAt": Utils.fromDateTimeToJson(updatedAt),
        "price": price,
        "inventoryManagement": inventoryManagement,
        "inventoryPolicy": inventoryPolicy,
        "taxable": taxable,
      };
}
