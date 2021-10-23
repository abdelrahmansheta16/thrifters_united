import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/models/Address.dart';
import 'package:thrifters_united/pages/Home/Brands.dart';
import 'package:thrifters_united/pages/Home/Kids.dart';
import 'package:thrifters_united/pages/Home/Men.dart';
import 'package:thrifters_united/pages/Home/Women.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            child: Icon(
              Icons.search_sharp,
              color: Colors.black,
              size: 24,
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
