import 'package:flutter/material.dart';
import 'package:thrifters_united/pages/Categories/Brands.dart';
import 'package:thrifters_united/pages/Categories/Kids.dart';
import 'package:thrifters_united/pages/Categories/Men.dart';
import 'package:thrifters_united/pages/Categories/Women.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
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
              labelColor: Color(0xff51c0a9),
              unselectedLabelColor: Colors.black38,
              indicatorColor: Color(0xff51c0a9),
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
                children: [Women(), Men(), Kids(), Brands()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
