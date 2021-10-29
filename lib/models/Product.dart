// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:thrifters_united/utils.dart';
import 'Category.dart';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.productId,
    this.title,
    this.images,
    this.categories,
    this.description,
    this.brand,
    this.color,
    this.type,
    this.size,
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
  List<Category> categories;
  String description;
  String brand;
  List<String> color;
  String type;
  List<String> size;
  bool isSoldOut = false;
  bool isBackorder;
  bool isVisible;
  DateTime publishedAt;
  DateTime updatedAt;
  num price;
  bool inventoryManagement = true;
  bool inventoryPolicy = true;
  bool taxable;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productID"],
        title: json["title"],
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x))
            : <String>[],
        categories: json["categories"] != null
            ? List<dynamic>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : <Product>[],
        description: json["description"],
        brand: json["brand"],
        color: json["color"] != null
            ? List<String>.from(json["color"].map((x) => x))
            : <String>[],
        type: json["type"],
        size: json["size"] != null
            ? List<String>.from(json["size"].map((x) => x))
            : <String>[],
        isSoldOut: json["isSoldOut"],
        isBackorder: json["isBackorder"],
        isVisible: json["isVisible"],
        publishedAt: Utils.toDateTime(json["publishedAt"]),
        updatedAt: Utils.toDateTime(json["updatedAt"]),
        price: json["price"],
        inventoryManagement: json["inventoryManagement"],
        inventoryPolicy: json["inventoryPolicy"],
        taxable: json["taxable"],
      );

  Map<String, dynamic> toJson() => {
        "productID": productId,
        "title": title,
        "images": images != null
            ? List<String>.from(images.map((x) => x))
            : <String>[],
        "categories": categories != null
            ? List<dynamic>.from(categories.map((x) => x.toJson()))
            : <Category>[],
        "description": description,
        "brand": brand,
        "color":
            color != null ? List<String>.from(color.map((x) => x)) : <String>[],
        "type": type,
        "size":
            size != null ? List<String>.from(size.map((x) => x)) : <String>[],
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
