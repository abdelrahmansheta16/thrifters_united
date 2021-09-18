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
      tabsWidth: MediaQuery.of(context).size.width * 0.32,
      tabBackgroundColor: Colors.white,
      selectedTabBackgroundColor: Color(0xff51c0a9),
      selectedTabTextStyle: TextStyle(color: Colors.black),
      tabTextStyle: TextStyle(color: Colors.black38),
      tabs: [
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
        Tab(
          child: CategoryTab(
            label: 'Category',
          ),
        ),
      ],
      contents: [
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
        Container(child: Text('Flutter'), padding: EdgeInsets.all(20)),
      ],
    );
  }
}
