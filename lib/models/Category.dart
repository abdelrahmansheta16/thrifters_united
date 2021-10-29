// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'Product.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.level,
    this.products,
    this.name,
    this.subCategories,
    this.isExpanded = false,
    this.isSelected = false,
  });

  num level;
  List<Product> products;
  String name;
  List<Category> subCategories;
  bool isExpanded;
  bool isSelected;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        level: json["level"],
        products: json["products"] != null
            ? List<Product>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : <Product>[],
        name: json["name"],
        subCategories: json["subCategories"] != null
            ? List<dynamic>.from(
                json["subCategories"].map((x) => Category.fromJson(x)))
            : <Category>[],
        isExpanded: json["isExpanded"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "products": products != null
            ? List<dynamic>.from(products.map((x) => x.toJson()))
            : <Product>[],
        "name": name,
        "subCategories": subCategories != null
            ? List<dynamic>.from(subCategories.map((x) => x.toJson()))
            : <Category>[],
        "isExpanded": isExpanded,
        "isSelected": isSelected,
      };
}
