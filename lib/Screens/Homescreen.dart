import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_classes/utils.dart';
import 'package:thrifters_united/FirebaseAPI/ProductAPI.dart';
import 'package:thrifters_united/customUi/FilteredProducts.dart';
import 'package:thrifters_united/pages/Home/Kids.dart';
import 'package:thrifters_united/pages/Home/Men.dart';
import 'package:thrifters_united/pages/Home/Women.dart';
import 'package:thrifters_united/pages/Home/notifications.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'HomeScreen');
    super.initState();
  }
  //
  // @override
  // void initState() {
  //   priceRanges.forEach((element) {
  //     FirebaseFirestore.instance
  //         .collection('price ranges')
  //         .withConverter<PriceRange>(
  //           fromFirestore: (snapshot, _) =>
  //               PriceRange.fromJson(snapshot.data()),
  //           toFirestore: (range, _) => range.toJson(),
  //         )
  //         .add(element);
  //   });
  //   super.initState();
  // }
  // @override
  // void initState() {
  //   Category kids = Category(name: 'kids', level: -1, subCategories: [
  //     Category(
  //       name: 'Clothing',
  //       parentCategory: 'kids',
  //       level: 0,
  //       subCategories: [
  //         Category(
  //           name: 'Girls',
  //           level: 1,
  //           parentCategory: 'Clothing',
  //           subCategories: [
  //             Category(
  //                 name: "T-Shirts & Vests",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Short Sleeve T-shirt",
  //                       parentCategory: 'T-Shirts & Vests',
  //                       level: 2),
  //                   Category(
  //                       name: "Long Sleeve T-shirt",
  //                       parentCategory: 'T-Shirts & Vests',
  //                       level: 2),
  //                   Category(
  //                       name: "Vests",
  //                       parentCategory: 'T-Shirts & Vests',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Cardigans & Sweaters",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sweaters",
  //                       parentCategory: 'Cardigans & Sweaters',
  //                       level: 2),
  //                   Category(
  //                       name: "Cardigans",
  //                       parentCategory: 'Cardigans & Sweaters',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Pants & Chinos",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Pants",
  //                       parentCategory: 'Pants & Chinos',
  //                       level: 2),
  //                   Category(
  //                       name: "Sweatpants",
  //                       parentCategory: 'Pants & Chinos',
  //                       level: 2),
  //                   Category(
  //                       name: "Chinos Pants",
  //                       parentCategory: 'Pants & Chinos',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Hoodies & Sweatshirts",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sweatshirts",
  //                       parentCategory: 'Hoodies & Sweatshirts',
  //                       level: 2),
  //                   Category(
  //                       name: "Hoodies",
  //                       parentCategory: 'Hoodies & Sweatshirts',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Nightwear",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sets", parentCategory: 'Nightwear', level: 2),
  //                   Category(
  //                       name: "Bottoms", parentCategory: 'Nightwear', level: 2),
  //                   Category(
  //                       name: "Tops", parentCategory: 'Nightwear', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Sportswear",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "T-Shirts & Vests",
  //                       parentCategory: 'Sportswear',
  //                       level: 2),
  //                   Category(
  //                       name: "Bottom", parentCategory: 'Sportswear', level: 2),
  //                   Category(
  //                       name: "Polo", parentCategory: 'Sportswear', level: 2),
  //                   Category(
  //                       name: "Sports Bras",
  //                       parentCategory: 'Sportswear',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Sportswear',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts", parentCategory: 'Sportswear', level: 2),
  //                   Category(
  //                       name: "Sets", parentCategory: 'Sportswear', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Jackets & Coats",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Jackets & Coats',
  //                       level: 2),
  //                   Category(
  //                       name: "Coats",
  //                       parentCategory: 'Jackets & Coats',
  //                       level: 2),
  //                   Category(
  //                       name: "Blazers",
  //                       parentCategory: 'Jackets & Coats',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Jeans",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Straight Jeans",
  //                       parentCategory: 'Jeans',
  //                       level: 2),
  //                   Category(
  //                       name: "Slim Jeans", parentCategory: 'Jeans', level: 2),
  //                   Category(
  //                       name: "Relaxed Jeans",
  //                       parentCategory: 'Jeans',
  //                       level: 2),
  //                   Category(
  //                       name: "Skinny Jeans",
  //                       parentCategory: 'Jeans',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Polo Shirts",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sports Polos",
  //                       parentCategory: 'Shorts',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Shorts",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sports Shorts",
  //                       parentCategory: 'Shorts',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts", parentCategory: 'Shorts', level: 2),
  //                   Category(
  //                       name: "Lounge Shorts",
  //                       parentCategory: 'Shorts',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Multi packs",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Pants & Chinos",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                   Category(
  //                       name: "Underwear & Socks",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                   Category(
  //                       name: "T-shirts & Vests",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Indian Clothing",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Kurtis",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Bottoms",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Plus Size Clothing",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Shirts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "T-shirts & Vests",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets & Coats",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Hoodies & Sweatshirts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Swimwear",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Classic Shorts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Indian Clothing",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Kurtis",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Bottoms",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //           ],
  //         ),
  //         Category(
  //           name: 'Boys',
  //           level: 1,
  //           parentCategory: 'Clothing',
  //           subCategories: [
  //             Category(
  //                 name: "T-Shirts & Vests",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Short Sleeve T-shirt",
  //                       parentCategory: 'T-Shirts & Vests',
  //                       level: 2),
  //                   Category(
  //                       name: "Long Sleeve T-shirt",
  //                       parentCategory: 'T-Shirts & Vests',
  //                       level: 2),
  //                   Category(
  //                       name: "Vests",
  //                       parentCategory: 'T-Shirts & Vests',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Cardigans & Sweaters",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sweaters",
  //                       parentCategory: 'Cardigans & Sweaters',
  //                       level: 2),
  //                   Category(
  //                       name: "Cardigans",
  //                       parentCategory: 'Cardigans & Sweaters',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Pants & Chinos",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Pants",
  //                       parentCategory: 'Pants & Chinos',
  //                       level: 2),
  //                   Category(
  //                       name: "Sweatpants",
  //                       parentCategory: 'Pants & Chinos',
  //                       level: 2),
  //                   Category(
  //                       name: "Chinos Pants",
  //                       parentCategory: 'Pants & Chinos',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Hoodies & Sweatshirts",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sweatshirts",
  //                       parentCategory: 'Hoodies & Sweatshirts',
  //                       level: 2),
  //                   Category(
  //                       name: "Hoodies",
  //                       parentCategory: 'Hoodies & Sweatshirts',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Nightwear",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sets", parentCategory: 'Nightwear', level: 2),
  //                   Category(
  //                       name: "Bottoms", parentCategory: 'Nightwear', level: 2),
  //                   Category(
  //                       name: "Tops", parentCategory: 'Nightwear', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Sportswear",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "T-Shirts & Vests",
  //                       parentCategory: 'Sportswear',
  //                       level: 2),
  //                   Category(
  //                       name: "Bottom", parentCategory: 'Sportswear', level: 2),
  //                   Category(
  //                       name: "Polo", parentCategory: 'Sportswear', level: 2),
  //                   Category(
  //                       name: "Sports Bras",
  //                       parentCategory: 'Sportswear',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Sportswear',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts", parentCategory: 'Sportswear', level: 2),
  //                   Category(
  //                       name: "Sets", parentCategory: 'Sportswear', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Jackets & Coats",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Jackets & Coats',
  //                       level: 2),
  //                   Category(
  //                       name: "Coats",
  //                       parentCategory: 'Jackets & Coats',
  //                       level: 2),
  //                   Category(
  //                       name: "Blazers",
  //                       parentCategory: 'Jackets & Coats',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Jeans",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Straight Jeans",
  //                       parentCategory: 'Jeans',
  //                       level: 2),
  //                   Category(
  //                       name: "Slim Jeans", parentCategory: 'Jeans', level: 2),
  //                   Category(
  //                       name: "Relaxed Jeans",
  //                       parentCategory: 'Jeans',
  //                       level: 2),
  //                   Category(
  //                       name: "Skinny Jeans",
  //                       parentCategory: 'Jeans',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Polo Shirts",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sports Polos",
  //                       parentCategory: 'Shorts',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Shorts",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Sports Shorts",
  //                       parentCategory: 'Shorts',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts", parentCategory: 'Shorts', level: 2),
  //                   Category(
  //                       name: "Lounge Shorts",
  //                       parentCategory: 'Shorts',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Multi packs",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Pants & Chinos",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                   Category(
  //                       name: "Underwear & Socks",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                   Category(
  //                       name: "T-shirts & Vests",
  //                       parentCategory: 'Multi packs',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Indian Clothing",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Kurtis",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Bottoms",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Plus Size Clothing",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Shirts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "T-shirts & Vests",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets & Coats",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Hoodies & Sweatshirts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Shorts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Swimwear",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Classic Shorts",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Indian Clothing",
  //                 parentCategory: 'Clothing',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Kurtis",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Bottoms",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                   Category(
  //                       name: "Jackets",
  //                       parentCategory: 'Indian Clothing',
  //                       level: 2),
  //                 ]),
  //           ],
  //         ),
  //       ],
  //     ),
  //     Category(
  //         name: 'Accessories',
  //         parentCategory: 'kids',
  //         level: 0,
  //         subCategories: [
  //           Category(
  //             name: 'Girls',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Homeware",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Kitchenware",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Decorative Accessories",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Soft Furnishings",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Candles & Scents",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Clocks", parentCategory: 'Homeware', level: 2),
  //                     Category(
  //                         name: "Books", parentCategory: 'Homeware', level: 2),
  //                   ]),
  //               Category(
  //                   name: "Jewelery",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Earnings",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                     Category(
  //                         name: "Necklaces",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                     Category(
  //                         name: "Bracelets",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                     Category(
  //                         name: "Rings", parentCategory: 'Jewelery', level: 2),
  //                     Category(
  //                         name: "Sets", parentCategory: 'Jewelery', level: 2),
  //                     Category(
  //                         name: "Keyrings",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Headwear",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Headbands",
  //                         parentCategory: 'Headwear',
  //                         level: 2),
  //                     Category(
  //                         name: "Hats", parentCategory: 'Headwear', level: 2),
  //                     Category(
  //                         name: "Face Masks",
  //                         parentCategory: 'Headwear',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Sunglasses",
  //                   parentCategory: 'Accessories',
  //                   level: 1),
  //               Category(
  //                   name: "Watches",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Analog Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                     Category(
  //                         name: "Digital Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                     Category(
  //                         name: "Smart Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                     Category(
  //                         name: "Sports Lifestyle Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Scarves", parentCategory: 'Accessories', level: 1),
  //               Category(
  //                   name: "Gloves", parentCategory: 'Accessories', level: 1),
  //               Category(
  //                   name: "Belts", parentCategory: 'Accessories', level: 1),
  //               Category(
  //                   name: "Travel Accessories",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Flight Accessories",
  //                         parentCategory: 'Travel Accessories',
  //                         level: 2),
  //                     Category(
  //                         name: "Luggage Tags & Passport Holders",
  //                         parentCategory: 'Travel Accessories',
  //                         level: 2),
  //                     Category(
  //                         name: "Umbrellas",
  //                         parentCategory: 'Travel Accessories',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Multipacks",
  //                   parentCategory: 'Accessories',
  //                   level: 1),
  //               Category(
  //                   name: "Sports Accessories",
  //                   parentCategory: 'Accessories',
  //                   level: 1),
  //             ],
  //           ),
  //           Category(
  //             name: 'Boys',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Homeware",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Kitchenware",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Decorative Accessories",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Soft Furnishings",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Candles & Scents",
  //                         parentCategory: 'Homeware',
  //                         level: 2),
  //                     Category(
  //                         name: "Clocks", parentCategory: 'Homeware', level: 2),
  //                     Category(
  //                         name: "Books", parentCategory: 'Homeware', level: 2),
  //                   ]),
  //               Category(
  //                   name: "Jewelery",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Earnings",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                     Category(
  //                         name: "Necklaces",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                     Category(
  //                         name: "Bracelets",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                     Category(
  //                         name: "Rings", parentCategory: 'Jewelery', level: 2),
  //                     Category(
  //                         name: "Sets", parentCategory: 'Jewelery', level: 2),
  //                     Category(
  //                         name: "Keyrings",
  //                         parentCategory: 'Jewelery',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Headwear",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Headbands",
  //                         parentCategory: 'Headwear',
  //                         level: 2),
  //                     Category(
  //                         name: "Hats", parentCategory: 'Headwear', level: 2),
  //                     Category(
  //                         name: "Face Masks",
  //                         parentCategory: 'Headwear',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Sunglasses",
  //                   parentCategory: 'Accessories',
  //                   level: 1),
  //               Category(
  //                   name: "Watches",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Analog Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                     Category(
  //                         name: "Digital Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                     Category(
  //                         name: "Smart Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                     Category(
  //                         name: "Sports Lifestyle Watches",
  //                         parentCategory: 'Watches',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Scarves", parentCategory: 'Accessories', level: 1),
  //               Category(
  //                   name: "Gloves", parentCategory: 'Accessories', level: 1),
  //               Category(
  //                   name: "Belts", parentCategory: 'Accessories', level: 1),
  //               Category(
  //                   name: "Travel Accessories",
  //                   parentCategory: 'Accessories',
  //                   level: 1,
  //                   subCategories: [
  //                     Category(
  //                         name: "Flight Accessories",
  //                         parentCategory: 'Travel Accessories',
  //                         level: 2),
  //                     Category(
  //                         name: "Luggage Tags & Passport Holders",
  //                         parentCategory: 'Travel Accessories',
  //                         level: 2),
  //                     Category(
  //                         name: "Umbrellas",
  //                         parentCategory: 'Travel Accessories',
  //                         level: 2),
  //                   ]),
  //               Category(
  //                   name: "Multipacks",
  //                   parentCategory: 'Accessories',
  //                   level: 1),
  //               Category(
  //                   name: "Sports Accessories",
  //                   parentCategory: 'Accessories',
  //                   level: 1),
  //             ],
  //           ),
  //         ]),
  //     Category(
  //         name: 'Home & LifeStyle',
  //         parentCategory: 'kids',
  //         level: 0,
  //         subCategories: [
  //           Category(name: 'Girls', subCategories: [
  //             Category(
  //                 name: "Home",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(name: "Living", parentCategory: 'Home', level: 2),
  //                   Category(name: "Kitchen", parentCategory: 'Home', level: 2),
  //                   Category(
  //                       name: "Party Supplies",
  //                       parentCategory: 'Home',
  //                       level: 2),
  //                   Category(name: "Bedroom", parentCategory: 'Home', level: 2),
  //                   Category(
  //                       name: "Games & Puzzles",
  //                       parentCategory: 'Home',
  //                       level: 2),
  //                   Category(
  //                       name: "Bathroom", parentCategory: 'Home', level: 2),
  //                   Category(
  //                       name: "Home Fragrance",
  //                       parentCategory: 'Home',
  //                       level: 2),
  //                   Category(name: "Outdoor", parentCategory: 'Home', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Kitchen & Dining",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Mugs",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Water Bottles & Travel Mugs",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Dinnerware & Serveware",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Storage & Accessories",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Cafetieres, Tea Pots & Tea Sets",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Cooking & Baking",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Glassware",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Stationary",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Notebook",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Pens & Pencils",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Desk Essentials",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Pencil Cases",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Stationery Sets",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Technology",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Tech Accessories",
  //                       parentCategory: 'Technology',
  //                       level: 2),
  //                   Category(
  //                       name: "Photography",
  //                       parentCategory: 'Technology',
  //                       level: 2),
  //                   Category(
  //                       name: "Audio", parentCategory: 'Technology', level: 2),
  //                   Category(
  //                       name: "Games", parentCategory: 'Technology', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Candles & Home Fragrance",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Candles",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                   Category(
  //                       name: "Diffusers & Room Sprays",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                   Category(
  //                       name: "Incense & Holders",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                   Category(
  //                       name: "Candle Holders & Accessories",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                 ]),
  //           ]),
  //           Category(name: 'Boys', subCategories: [
  //             Category(
  //                 name: "Home",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(name: "Living", parentCategory: 'Home', level: 2),
  //                   Category(name: "Kitchen", parentCategory: 'Home', level: 2),
  //                   Category(
  //                       name: "Party Supplies",
  //                       parentCategory: 'Home',
  //                       level: 2),
  //                   Category(name: "Bedroom", parentCategory: 'Home', level: 2),
  //                   Category(
  //                       name: "Games & Puzzles",
  //                       parentCategory: 'Home',
  //                       level: 2),
  //                   Category(
  //                       name: "Bathroom", parentCategory: 'Home', level: 2),
  //                   Category(
  //                       name: "Home Fragrance",
  //                       parentCategory: 'Home',
  //                       level: 2),
  //                   Category(name: "Outdoor", parentCategory: 'Home', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Kitchen & Dining",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Mugs",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Water Bottles & Travel Mugs",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Dinnerware & Serveware",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Storage & Accessories",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Cafetieres, Tea Pots & Tea Sets",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Cooking & Baking",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                   Category(
  //                       name: "Glassware",
  //                       parentCategory: 'Kitchen & Dining',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Stationary",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Notebook",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Pens & Pencils",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Desk Essentials",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Pencil Cases",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                   Category(
  //                       name: "Stationery Sets",
  //                       parentCategory: 'Stationary',
  //                       level: 2),
  //                 ]),
  //             Category(
  //                 name: "Technology",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Tech Accessories",
  //                       parentCategory: 'Technology',
  //                       level: 2),
  //                   Category(
  //                       name: "Photography",
  //                       parentCategory: 'Technology',
  //                       level: 2),
  //                   Category(
  //                       name: "Audio", parentCategory: 'Technology', level: 2),
  //                   Category(
  //                       name: "Games", parentCategory: 'Technology', level: 2),
  //                 ]),
  //             Category(
  //                 name: "Candles & Home Fragrance",
  //                 parentCategory: 'Home & LifeStyle',
  //                 level: 1,
  //                 subCategories: [
  //                   Category(
  //                       name: "Candles",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                   Category(
  //                       name: "Diffusers & Room Sprays",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                   Category(
  //                       name: "Incense & Holders",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                   Category(
  //                       name: "Candle Holders & Accessories",
  //                       parentCategory: 'Candles & Home Fragrance',
  //                       level: 2),
  //                 ]),
  //           ]),
  //         ]),
  //     Category(name: 'Shoes', parentCategory: 'kids', level: 0, subCategories: [
  //       Category(name: 'Girls', subCategories: [
  //         Category(
  //             name: "Sneakers",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Low-top Sneakers",
  //                   parentCategory: 'Sneakers',
  //                   level: 2),
  //               Category(
  //                   name: "High-top Sneakers",
  //                   parentCategory: 'Sneakers',
  //                   level: 2),
  //             ]),
  //         Category(
  //             name: "Sandals",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Casual Sandals",
  //                   parentCategory: 'Sandals',
  //                   level: 2),
  //             ]),
  //         Category(
  //             name: "Sports Shoes",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Trainers", parentCategory: 'Sports Shoes', level: 2),
  //               Category(
  //                   name: "Basketball",
  //                   parentCategory: 'Sports Shoes',
  //                   level: 2),
  //               Category(
  //                   name: "Football Shoes",
  //                   parentCategory: 'Sports Shoes',
  //                   level: 2),
  //             ]),
  //         Category(
  //             name: "Boots",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Casual Boots", parentCategory: 'Boots', level: 2),
  //               Category(
  //                   name: "Formal Boots", parentCategory: 'Boots', level: 2),
  //             ]),
  //       ]),
  //       Category(name: 'Boys', subCategories: [
  //         Category(
  //             name: "Sneakers",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Low-top Sneakers",
  //                   parentCategory: 'Sneakers',
  //                   level: 2),
  //               Category(
  //                   name: "High-top Sneakers",
  //                   parentCategory: 'Sneakers',
  //                   level: 2),
  //             ]),
  //         Category(
  //             name: "Sandals",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Casual Sandals",
  //                   parentCategory: 'Sandals',
  //                   level: 2),
  //             ]),
  //         Category(
  //             name: "Sports Shoes",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Trainers", parentCategory: 'Sports Shoes', level: 2),
  //               Category(
  //                   name: "Basketball",
  //                   parentCategory: 'Sports Shoes',
  //                   level: 2),
  //               Category(
  //                   name: "Football Shoes",
  //                   parentCategory: 'Sports Shoes',
  //                   level: 2),
  //             ]),
  //         Category(
  //             name: "Boots",
  //             parentCategory: 'Shoes',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Casual Boots", parentCategory: 'Boots', level: 2),
  //               Category(
  //                   name: "Formal Boots", parentCategory: 'Boots', level: 2),
  //             ]),
  //       ]),
  //     ]),
  //     Category(name: 'Bags', parentCategory: 'kids', level: 0, subCategories: [
  //       Category(name: 'Girls', subCategories: [
  //         Category(
  //           name: "Wash Bags",
  //           parentCategory: 'Bags',
  //           level: 1,
  //         ),
  //         Category(
  //           name: "Messenger Bags",
  //           parentCategory: 'Bags',
  //           level: 1,
  //         ),
  //         Category(
  //             name: "Small Leather Goods",
  //             parentCategory: 'Bags',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                 name: "Wallets",
  //                 parentCategory: 'Small Leather Goods',
  //                 level: 2,
  //               ),
  //               Category(
  //                 name: "Card Holders",
  //                 parentCategory: 'Small Leather Goods',
  //                 level: 2,
  //               ),
  //             ]),
  //         Category(
  //             name: "Sports Bags",
  //             parentCategory: 'Bags',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Backpacks", parentCategory: 'Sports Bags', level: 2),
  //               Category(
  //                   name: "Duffel Bags",
  //                   parentCategory: 'Sports Bags',
  //                   level: 2),
  //             ]),
  //         Category(name: "Cosmetic Bags", parentCategory: 'Bags', level: 1),
  //       ]),
  //       Category(name: 'Boys', subCategories: [
  //         Category(
  //           name: "Wash Bags",
  //           parentCategory: 'Bags',
  //           level: 1,
  //         ),
  //         Category(
  //           name: "Messenger Bags",
  //           parentCategory: 'Bags',
  //           level: 1,
  //         ),
  //         Category(
  //             name: "Small Leather Goods",
  //             parentCategory: 'Bags',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                 name: "Wallets",
  //                 parentCategory: 'Small Leather Goods',
  //                 level: 2,
  //               ),
  //               Category(
  //                 name: "Card Holders",
  //                 parentCategory: 'Small Leather Goods',
  //                 level: 2,
  //               ),
  //             ]),
  //         Category(
  //             name: "Sports Bags",
  //             parentCategory: 'Bags',
  //             level: 1,
  //             subCategories: [
  //               Category(
  //                   name: "Backpacks", parentCategory: 'Sports Bags', level: 2),
  //               Category(
  //                   name: "Duffel Bags",
  //                   parentCategory: 'Sports Bags',
  //                   level: 2),
  //             ]),
  //         Category(name: "Cosmetic Bags", parentCategory: 'Bags', level: 1),
  //       ]),
  //     ]),
  //   ]);
  //   ProductAPI.addCategory(category: kids, categoryName: "kids");
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   FirebaseAuth.instance.userChanges().listen((user) {
  //     if (user != null) {
  //       Address address = Address(
  //           streetAddress: 'streetAddress',
  //           state: 'state',
  //           postalCode: 'postalCode',
  //           city: 'city');
  //       UserAPI.addAddresses(address, user.uid);
  //     }
  //   });
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   Product product = Product(
  //       title: 'title',
  //       images: [
  //         'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80',
  //         'https://images.unsplash.com/photo-1518568740560-333139a27e72?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhY2glMjBsb3ZlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
  //         'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'
  //       ],
  //       description: 'description',
  //       type: 'type',
  //       brand: 'brand',
  //       size: ['1', '2', '3'],
  //       category: 'category',
  //       color: ['1', '2', '3'],
  //       isLowQuantity: true,
  //       isSoldOut: true,
  //       isBackorder: true,
  //       isVisible: true,
  //       price: 651,
  //       inventoryManagement: true,
  //       inventoryPolicy: true,
  //       taxable: true);
  //   ProductAPI.addProducts(product: product);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment(-1, 0),
              child: Text(
                'Thrifters',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xff303030),
                  fontFamily: 'Roboto Mono',
                  fontSize: 26,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width * 0.5,
              child: TypeAheadField<Brand>(
                textFieldConfiguration: TextFieldConfiguration(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search by Brand',
                    prefixIcon: Icon(EvaIcons.searchOutline),
                    contentPadding: EdgeInsets.all(8),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                minCharsForSuggestions: 1,
                noItemsFoundBuilder: (context) {
                  return Text('No Brands Found');
                },
                errorBuilder: (context, object) {
                  return Text('error searching for brand');
                },
                suggestionsCallback: (pattern) {
                  return Utils.getSuggestions(pattern);
                },
                onSuggestionSelected: (Brand suggestion) {
                  print(suggestion.name);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => FilteredProducts(
                              brand: suggestion,
                            )),
                  );
                },
                itemBuilder: (BuildContext context, Brand itemData) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            itemData.name,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Color(0xFFD2D2D2),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //             builder: (context) => SearchProductWidget()),
          //       );
          //     },
          //     icon: Icon(
          //       Icons.search_sharp,
          //       color: Colors.black,
          //       size: 24,
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                EvaIcons.bellOutline,
                color: Colors.black,
                size: 24,
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              labelColor: Color(0xff50c0a8),
              unselectedLabelColor: Colors.black38,
              indicatorColor: Color(0xff50c0a8),
              tabs: [
                Tab(
                  text: 'Women',
                ),
                Tab(
                  text: 'Men',
                ),
                Tab(
                  text: 'Kids',
                ),
                // Tab(
                //   text: 'Brands',
                // )
              ],
            ),
            Divider(
              height: 1.5,
              thickness: 1.0,
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Women(),
                  Men(),
                  Kids(),
                  // Brands(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
