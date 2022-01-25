import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/customUi/CategoryTab.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class Men extends StatefulWidget {
  const Men({Key key}) : super(key: key);

  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {
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
            text: 'Brands',
          ),
          Tab(
            text: 'Grooming',
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
          Container(),
          Container(),
          Container(),
        ]);
  }
}

// return VerticalTabs(
//   tabsWidth: MediaQuery.of(context).size.width * 0.32,
//   tabBackgroundColor: Colors.white,
//   selectedTabBackgroundColor: Color(0xff51c0a9),
//   selectedTabTextStyle: TextStyle(color: Colors.black),
//   tabTextStyle: TextStyle(color: Colors.black38),
//   tabs: [
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//     Tab(
//       child: CategoryTab(
//         label: 'Category',
//       ),
//     ),
//   ],
//   contents: [
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//     Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
//   ],
// );
