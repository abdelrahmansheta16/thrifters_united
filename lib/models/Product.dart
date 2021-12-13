// // To parse this JSON data, do
// //
// //     final product = productFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:thrifters_united/utils.dart';
// import 'Category.dart';
//
// List<Product> productFromJson(String str) =>
//     List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
//
// String productToJson(List<Product> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Product {
//   Product({
//     this.productId,
//     this.title,
//     this.images,
//     this.categories,
//     this.description,
//     this.brand,
//     this.color,
//     this.type,
//     this.size,
//     this.isSoldOut,
//     this.inWishList = false,
//     this.isBackorder,
//     this.isVisible,
//     this.publishedAt,
//     this.updatedAt,
//     this.price,
//     this.inventoryManagement,
//     this.inventoryPolicy,
//     this.taxable,
//   });
//
//   String productId;
//   String title;
//   List<String> images;
//   List<Category> categories;
//   String description;
//   Brand brand;
//   List<String> color;
//   String type;
//   List<Size> size;
//   bool isSoldOut;
//   bool inWishList;
//   bool isBackorder;
//   bool isVisible;
//   DateTime publishedAt;
//   DateTime updatedAt;
//   num price;
//   bool inventoryManagement;
//   bool inventoryPolicy;
//   bool taxable;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         productId: json["productID"],
//         title: json["title"],
//         images: json["images"] != null
//             ? List<String>.from(json["images"].map((x) => x))
//             : <String>[],
//         categories: json["categories"] != null
//             ? List<Category>.from(
//                 json["categories"].map((x) => Category.fromJson(x)))
//             : <Category>[],
//         description: json["description"],
//         brand: Brand.fromJson(json["brand"]),
//         color: json["color"] != null
//             ? List<String>.from(json["color"].map((x) => x))
//             : <String>[],
//         type: json["type"],
//         size: json["size"] != null
//             ? List<Size>.from(json["size"].map((x) => Size.fromJson(x)))
//             : <Size>[],
//         isSoldOut: json["isSoldOut"],
//         inWishList: json["inWishList"],
//         isBackorder: json["isBackorder"],
//         isVisible: json["isVisible"],
//         publishedAt: Utils.toDateTime(json["publishedAt"]),
//         updatedAt: Utils.toDateTime(json["updatedAt"]),
//         price: json["price"],
//         inventoryManagement: json["inventoryManagement"],
//         inventoryPolicy: json["inventoryPolicy"],
//         taxable: json["taxable"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "productID": productId,
//         "title": title,
//         "images": images != null
//             ? List<String>.from(images.map((x) => x))
//             : <String>[],
//         "categories": categories != null
//             ? List<dynamic>.from(categories.map((x) => x.toJson()))
//             : <Category>[],
//         "description": description,
//         "brand": brand.toJson(),
//         "color":
//             color != null ? List<String>.from(color.map((x) => x)) : <String>[],
//         "type": type,
//         "size": size != null
//             ? List<dynamic>.from(size.map((x) => x.toJson()))
//             : <Size>[],
//         "isSoldOut": isSoldOut,
//         "inWishList": inWishList,
//         "isBackorder": isBackorder,
//         "isVisible": isVisible,
//         "publishedAt": Utils.fromDateTimeToJson(publishedAt),
//         "updatedAt": Utils.fromDateTimeToJson(updatedAt),
//         "price": price,
//         "inventoryManagement": inventoryManagement,
//         "inventoryPolicy": inventoryPolicy,
//         "taxable": taxable,
//       };
// }
//
// Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));
//
// String brandToJson(Brand data) => json.encode(data.toJson());
//
// class Brand {
//   Brand({
//     this.name,
//     this.isSelected = false,
//   });
//
//   String name;
//   bool isSelected;
//
//   factory Brand.fromJson(Map<String, dynamic> json) => Brand(
//         name: json["name"],
//         isSelected: json["isSelected"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "isSelected": isSelected,
//       };
// }
//
// class Size {
//   Size({
//     this.name,
//     this.isSelected = false,
//   });
//
//   String name;
//   bool isSelected;
//
//   factory Size.fromJson(Map<String, dynamic> json) => Size(
//         name: json["name"],
//         isSelected: json["isSelected"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "isSelected": isSelected,
//       };
// }
