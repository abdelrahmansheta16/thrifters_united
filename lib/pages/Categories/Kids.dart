import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/customUi/CategoryTab.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class Kids extends StatefulWidget {
  const Kids({Key key}) : super(key: key);

  @override
  _KidsState createState() => _KidsState();
}

class _KidsState extends State<Kids> {
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
            text: 'Shop by age',
          ),
          Tab(
            text: 'Girls',
          ),
          Tab(
            text: 'Boys',
          ),
          Tab(
            text: 'Sports',
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
        ]);
  }
}
