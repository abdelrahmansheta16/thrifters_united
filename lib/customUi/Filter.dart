import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/customUi/CategoryFilter.dart';
import 'package:thrifters_united/customUi/ChooseCategory.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'CategoryContainer.dart';

class FilterWidget extends StatefulWidget {
  FilterWidget({Key key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Filter',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<FilterProvider>(builder: (context, model, child) {
          return ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoryFilter()),
                  );
                },
                title: Text(
                  'Category',
                  style: FlutterFlowTheme.title3,
                ),
                subtitle: CategoryContainer(
                  list: model.categories,
                ),
                tileColor: Colors.white,
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              ListTile(
                title: Text(
                  'Brand',
                  style: FlutterFlowTheme.title3,
                ),
                tileColor: Colors.white,
                subtitle: CategoryContainer(
                  list: model.brands,
                ),
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              ListTile(
                title: Text(
                  'Color',
                  style: FlutterFlowTheme.title3,
                ),
                subtitle: CategoryContainer(
                  list: model.color,
                ),
                tileColor: Colors.white,
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              ListTile(
                title: Text(
                  'Size',
                  style: FlutterFlowTheme.title3,
                ),
                subtitle: CategoryContainer(
                  list: model.sizes,
                ),
                tileColor: Colors.white,
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              ListTile(
                title: Text(
                  'Price',
                  style: FlutterFlowTheme.title3,
                ),
                subtitle: CategoryContainer(
                  list: model.prices,
                ),
                tileColor: Colors.white,
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              ListTile(
                title: Text(
                  'New arrivals',
                  style: FlutterFlowTheme.title3,
                ),
                tileColor: Colors.white,
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              SwitchListTile(
                value: switchListTileValue ??= true,
                onChanged: (newValue) =>
                    setState(() => switchListTileValue = newValue),
                title: Text(
                  'Discounts only',
                  style: FlutterFlowTheme.title3,
                ),
                tileColor: Colors.white,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              ),
              ListTile(
                title: Text(
                  'Bundles',
                  style: FlutterFlowTheme.title3,
                ),
                tileColor: Colors.white,
                dense: false,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
