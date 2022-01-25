import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/customUi/CategoryTab.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import 'Kids.dart';
import 'Men.dart';

class Women extends StatefulWidget {
  const Women({Key key}) : super(key: key);

  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  GlobalKey verticalTabKey = new GlobalKey(debugLabel: 'btm_app_bar');

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return VerticalTabs(
        indicatorWidth: 0,
        selectedTabTextStyle: TextStyle(
          color: Colors.black,
        ),
        selectedTabBackgroundColor: Colors.white,
        tabsWidth: MediaQuery.of(context).size.width * 0.33,
        tabs: [
          Tab(
            text: 'Promotions',
          ),
          Tab(
            text: 'Sale',
          ),
          Tab(
            text: 'New arrivals',
          ),
          Tab(
            text: 'Clothing',
          ),
          Tab(
            text: 'Shoes',
          ),
          Tab(
            text: 'Accessories',
          ),
          Tab(
            text: 'Bags',
          ),
          Tab(
            text: 'Sports',
          ),
          Tab(
            text: 'Beauty',
          ),
          Tab(
            text: 'Brands',
          ),
          Tab(
            text: 'Homeware',
          ),
          Tab(
            text: 'Premium',
          ),
          Tab(
            text: 'Gifts',
          ),
          Tab(
            text: 'Modest',
          ),
        ],
        contents: [
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
          Container(),
        ]);
  }
}
