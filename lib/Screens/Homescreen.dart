import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thrifters_united/FirebaseAPI/ProductAPI.dart';
import 'package:thrifters_united/customUi/CategoryFilter.dart';
import 'package:thrifters_united/models/Category.dart';
import 'package:thrifters_united/pages/Home/Brands.dart';
import 'package:thrifters_united/pages/Home/Kids.dart';
import 'package:thrifters_united/pages/Home/Men.dart';
import 'package:thrifters_united/pages/Home/Women.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Category women = Category(name: 'women', level: -1, subCategories: [
      Category(name: 'Clothing', level: 0, subCategories: [
        Category(name: "Dresses", level: 1, subCategories: [
          Category(name: "Casual Dresses", level: 2),
          Category(name: "Mini Dresses", level: 2),
          Category(name: "Maxi Dresses", level: 2),
          Category(name: "Evening Dresses", level: 2),
          Category(name: "Event Dresses", level: 2),
          Category(name: "Formal Dresses", level: 2),
          Category(name: "Party Dresses", level: 2),
        ]),
        Category(name: "Tops", level: 1, subCategories: [
          Category(name: "Long Sleeve Tops", level: 2),
          Category(name: "Shirts & Blouses", level: 2),
          Category(name: "Tunics", level: 2),
          Category(name: "Short Sleeve Tops", level: 2),
          Category(name: "Sleeveless Tops", level: 2),
          Category(name: "Body & Cropped", level: 2),
        ]),
        Category(name: "T-Shirts & Vests", level: 1, subCategories: [
          Category(name: "Short Sleeve T-shirt", level: 2),
          Category(name: "Long Sleeve T-shirt", level: 2),
          Category(name: "Vests", level: 2),
        ]),
        Category(name: "Cardigans & Sweaters", level: 1, subCategories: [
          Category(name: "Sweaters", level: 2),
          Category(name: "Cardigans", level: 2),
        ]),
        Category(name: "Pants & Leggings", level: 1, subCategories: [
          Category(name: "Pants", level: 2),
          Category(name: "Sweatpants", level: 2),
          Category(name: "Sets", level: 2),
          Category(name: "Leggings", level: 2),
        ]),
        Category(name: "Arabian Clothing", level: 1, subCategories: [
          Category(name: "Tops", level: 2),
          Category(name: "Dresses", level: 2),
          Category(name: "Bottoms", level: 2),
          Category(name: "Sets", level: 2),
          Category(name: "Abayas", level: 2),
          Category(name: "Jalabiyas", level: 2),
          Category(name: "Kaftans", level: 2),
        ]),
        Category(name: "Hoodies & Sweatshirts", level: 1, subCategories: [
          Category(name: "Sweatshirts", level: 2),
          Category(name: "Hoodies", level: 2),
        ]),
        Category(name: "Nightwear", level: 1, subCategories: [
          Category(name: "All Nightwear", level: 2),
          Category(name: "Pyjamas", level: 2),
          Category(name: "Nighties & Sleep Shirts", level: 2),
          Category(name: "Bedroom Slippers", level: 2),
          Category(name: "Robes", level: 2),
          Category(name: "Slips", level: 2),
          Category(name: "Onesies", level: 2),
          Category(name: "Loungewear", level: 2),
        ]),
        Category(name: "Sportswear", level: 1, subCategories: [
          Category(name: "T-Shirts", level: 2),
          Category(name: "Bottom", level: 2),
          Category(name: "Hoodies & Sweatshirts", level: 2),
          Category(name: "Sports Bras", level: 2),
          Category(name: "Jackets", level: 2),
          Category(name: "Shorts", level: 2),
          Category(name: "Sets", level: 2),
        ]),
        Category(name: "Lingerie", level: 1, subCategories: [
          Category(name: "Bras", level: 2),
          Category(name: "Briefs", level: 2),
          Category(name: "Training", level: 2),
          Category(name: "Lingerie", level: 2),
          Category(name: "Backless Bras", level: 2),
          Category(name: "Slips", level: 2),
          Category(name: "Bodies & Corsets", level: 2),
        ]),
        Category(name: "Jackets & Coats", level: 1, subCategories: [
          Category(name: "Jackets", level: 2),
          Category(name: "Coats", level: 2),
          Category(name: "Blazers", level: 2),
        ]),
        Category(name: "Shorts", level: 1, subCategories: [
          Category(name: "Mini", level: 2),
          Category(name: "Denim", level: 2),
          Category(name: "Sets", level: 2),
        ]),
        Category(name: "Multi packs", level: 1, subCategories: [
          Category(name: "Lingerie", level: 2),
          Category(name: "Pants & Leggings", level: 2),
          Category(name: "Cardigans & Sweaters", level: 2),
          Category(name: "Nightwear", level: 2),
          Category(name: "T-shirts & Vests", level: 2),
        ]),
        Category(name: "Socks & Hosiery", level: 1),
        Category(name: "Indian Clothing", level: 1, subCategories: [
          Category(name: "Dresses", level: 2),
          Category(name: "Tops", level: 2),
          Category(name: "Tunics", level: 2),
          Category(name: "Kurtis", level: 2),
          Category(name: "Dupattas", level: 2),
          Category(name: "Pants", level: 2),
          Category(name: "Skirts", level: 2),
          Category(name: "Sarees", level: 2),
          Category(name: "Jackets", level: 2),
        ]),
        Category(name: "Maternity Clothing", level: 1, subCategories: [
          Category(name: "Tops", level: 2),
          Category(name: "Pants & Lingerie", level: 2),
          Category(name: "Lingerie & Nightwear", level: 2),
          Category(name: "Dresses", level: 2),
          Category(name: "Skirts", level: 2),
          Category(name: "Jeans", level: 2),
        ]),
        Category(name: "Kimonos & Capes", level: 1),
        Category(name: "Petite Clothing", level: 1, subCategories: [
          Category(name: "Pants & Leggings", level: 2),
          Category(name: "Jeans", level: 2),
          Category(name: "Jackets & Coats", level: 2),
        ]),
        Category(name: "Tall Clothing", level: 1),
      ]),
      Category(name: 'Accessories', level: 0, subCategories: [
        Category(name: "Homeware", level: 1, subCategories: [
          Category(name: "Kitchenware", level: 2),
          Category(name: "Decorative Accessories", level: 2),
          Category(name: "Soft Furnishings", level: 2),
          Category(name: "Candles & Scents", level: 2),
          Category(name: "Clocks", level: 2),
          Category(name: "Books", level: 2),
        ]),
        Category(name: "Jewelery", level: 1, subCategories: [
          Category(name: "Earnings", level: 2),
          Category(name: "Necklaces", level: 2),
          Category(name: "Bracelets", level: 2),
          Category(name: "Rings", level: 2),
          Category(name: "Sets", level: 2),
          Category(name: "Anklets", level: 2),
          Category(name: "Keyrings", level: 2),
          Category(name: "Pins & Badges", level: 2),
        ]),
        Category(name: "Headwear", level: 1, subCategories: [
          Category(name: "Headbands", level: 2),
          Category(name: "Hats", level: 2),
          Category(name: "Face Masks", level: 2),
          Category(name: "Hijab", level: 2),
        ]),
        Category(name: "Sunglasses", level: 1),
        Category(name: "Watches", level: 1, subCategories: [
          Category(name: "Analog Watches", level: 2),
          Category(name: "Digital Watches", level: 2),
          Category(name: "Smart Watches", level: 2),
          Category(name: "Sports Lifestyle Watches", level: 2),
        ]),
        Category(name: "Scarves", level: 1),
        Category(name: "Belts", level: 1),
        Category(name: "Travel Accessories", level: 1, subCategories: [
          Category(name: "Flight Accessories", level: 2),
          Category(name: "Beach Towels", level: 2),
          Category(name: "Pool Floats", level: 2),
          Category(name: "Luggage Tags & Passport Holders", level: 2),
          Category(name: "Umbrellas", level: 2),
        ]),
        Category(name: "Multipacks", level: 1),
        Category(name: "Sports Accessories", level: 1),
      ]),
      Category(name: 'Beauty', level: 0, subCategories: [
        Category(name: "Makeup", level: 1, subCategories: [
          Category(name: "Face", level: 2),
          Category(name: "Lips", level: 2),
          Category(name: "Eyes", level: 2),
          Category(name: "Accessories", level: 2),
        ]),
        Category(name: "Bath & Body", level: 1, subCategories: [
          Category(name: "Anti-Aging", level: 2),
          Category(name: "Moisturizer", level: 2),
          Category(name: "Facial Cleansers", level: 2),
          Category(name: "Scrubs & Exfoliates", level: 2),
          Category(name: "Sun Protection & Tanning", level: 2),
          Category(name: "Deodorants", level: 2),
          Category(name: "Soaps", level: 2),
          Category(name: "Body Wash", level: 2),
          Category(name: "Body Salts", level: 2),
        ]),
        Category(name: "Hair Care", level: 1, subCategories: [
          Category(name: "Other", level: 2),
          Category(name: "Shampoo", level: 2),
          Category(name: "Conditioner", level: 2),
          Category(name: "Styling Tools", level: 2),
        ]),
        Category(name: "Fragrances", level: 1, subCategories: [
          Category(name: "Eau de Parfum", level: 2),
          Category(name: "Eau de Toilette", level: 2),
        ]),
        Category(name: "Gift Sets", level: 1, subCategories: [
          Category(name: "Bath & Body", level: 2),
          Category(name: "Fragrances & Body Lotion", level: 2),
        ]),
        Category(name: "Nail Care", level: 1, subCategories: [
          Category(name: "Nail Polish", level: 2),
          Category(name: "Nail Treatment", level: 2),
          Category(name: "Nail Polish Remover", level: 2),
        ]),
        Category(name: "Health & Wellbeing", level: 1, subCategories: [
          Category(name: "De-Stress & Relax", level: 2),
          Category(name: "Sleep", level: 2),
          Category(name: "Superfoods & Supplements", level: 2),
        ]),
      ]),
      Category(name: 'Home & LifeStyle', level: 0, subCategories: [
        Category(name: "Home", level: 1, subCategories: [
          Category(name: "Living", level: 2),
          Category(name: "Kitchen", level: 2),
          Category(name: "Party Supplies", level: 2),
          Category(name: "Bedroom", level: 2),
          Category(name: "Games & Puzzles", level: 2),
          Category(name: "Bathroom", level: 2),
          Category(name: "Home Fragrance", level: 2),
          Category(name: "Outdoor", level: 2),
        ]),
        Category(name: "Kitchen & Dining", level: 1, subCategories: [
          Category(name: "Mugs", level: 2),
          Category(name: "Water Bottles & Travel Mugs", level: 2),
          Category(name: "Dinnerware & Serveware", level: 2),
          Category(name: "Storage & Accessories", level: 2),
          Category(name: "Cafetieres, Tea Pots & Tea Sets", level: 2),
          Category(name: "Cooking & Baking", level: 2),
          Category(name: "Glassware", level: 2),
          Category(name: "Oven Gloves, Tea Towels & Aprons", level: 2),
          Category(name: "Lunch Bags & Boxes", level: 2),
          Category(name: "Kitchen Appliances", level: 2),
          Category(name: "Outdoor", level: 2),
        ]),
        Category(name: "Stationary", level: 1, subCategories: [
          Category(name: "Notebook", level: 2),
          Category(name: "Pens & Pencils", level: 2),
          Category(name: "Desk Essentials", level: 2),
          Category(name: "Pencil Cases", level: 2),
          Category(name: "Stationery Sets", level: 2),
          Category(name: "Planners", level: 2),
        ]),
        Category(name: "Technology", level: 1, subCategories: [
          Category(name: "Tech Accessories", level: 2),
          Category(name: "Photography", level: 2),
          Category(name: "Audio", level: 2),
          Category(name: "Games", level: 2),
        ]),
        Category(name: "Candles & Home Fragrance", level: 1, subCategories: [
          Category(name: "Candles", level: 2),
          Category(name: "Diffusers & Room Sprays", level: 2),
          Category(name: "Incense & Holders", level: 2),
          Category(name: "Candle Holders & Accessories", level: 2),
        ]),
      ]),
      Category(name: 'Shoes', level: 0, subCategories: [
        Category(name: "Sneakers", level: 1, subCategories: [
          Category(name: "Low-top Sneakers", level: 2),
          Category(name: "High-top Sneakers", level: 2),
        ]),
        Category(name: "Sandals", level: 1, subCategories: [
          Category(name: "Flat Sandals", level: 2),
          Category(name: "Mid-Heel Sandals", level: 2),
          Category(name: "High-Heel Sandals", level: 2),
          Category(name: "Wedge Sandals", level: 2),
        ]),
        Category(name: "Sports Shoes", level: 1),
        Category(name: "Flat Shoes", level: 1, subCategories: [
          Category(name: "Ballerinas", level: 2),
          Category(name: "Moccasins", level: 2),
          Category(name: "Slip Ons", level: 2),
          Category(name: "Espadrilles", level: 2),
        ]),
        Category(name: "Pumps", level: 1, subCategories: [
          Category(name: "High-Heel Pumps", level: 2),
          Category(name: "Mid-Heel Pumps", level: 2),
          Category(name: "Wedge Pumps", level: 2),
        ]),
        Category(name: "Boots", level: 1, subCategories: [
          Category(name: "Ankle Boots", level: 2),
          Category(name: "Knee Boots", level: 2),
        ]),
        Category(name: "Bedroom Slippers", level: 1),
        Category(name: "Comfort Shoes", level: 1),
        Category(name: "Flip Flops", level: 1),
      ]),
      Category(name: 'Bags', level: 0, subCategories: [
        Category(name: "Handbags", level: 1, subCategories: [
          Category(name: "Crossbody", level: 2),
          Category(name: "Shoppers\\Totes", level: 2),
          Category(name: "Satchels", level: 2),
          Category(name: "Clutches", level: 2),
          Category(name: "Backpacks", level: 2),
          Category(name: "Hobo", level: 2),
          Category(name: "Duffel Bags", level: 2),
        ]),
        Category(name: "Small Leather Goods", level: 1),
        Category(name: "Sports Bags", level: 1, subCategories: [
          Category(name: "Backpacks", level: 2),
          Category(name: "Duffel Bags", level: 2),
          Category(name: "Shoppers\\Totes", level: 2),
        ]),
        Category(name: "Cosmetic Bags", level: 1),
      ]),
    ]);
    ProductAPI.addCategory(category: women, categoryName: "women");
    super.initState();
  }

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
        title: Align(
          alignment: Alignment(-1, 0),
          child: Text(
            'Thrifters',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xff303030),
              fontFamily: 'Roboto Mono',
              fontSize: 30,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => CategoryFilter()),
                // );
              },
              icon: Icon(
                Icons.search_sharp,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Icon(
              Icons.card_giftcard_sharp,
              color: Colors.red,
              size: 24,
            ),
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 4,
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
                Tab(
                  text: 'Brands',
                )
              ],
            ),
            Divider(
              height: 1.5,
              thickness: 1.0,
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [Women(), Men(), Kids(), Brands()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
