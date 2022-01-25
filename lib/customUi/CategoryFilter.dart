import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/FirebaseAPI/ProductAPI.dart';
import 'package:thrifters_united/customUi/ChooseCategory.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> category;
  CategoryFilter({Key key, this.category}) : super(key: key);

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Categories',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<Category>>(
          stream: ProductAPI.loadCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            Category currentCategory;
            if (widget.category.length > 0) {
              currentCategory = snapshot.data.docs
                  .where((element) => element.id == widget.category[0])
                  .first
                  .data();
            } else {
              currentCategory = snapshot.data.docs
                  .where((element) => element.id == 'women')
                  .first
                  .data();
            }

            return ChooseCategory(category: currentCategory);
          }),
    );
  }
}
