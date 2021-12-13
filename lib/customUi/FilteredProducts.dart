import 'package:thrifters_classes/thrifters_classes.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilteredProducts extends StatefulWidget {
  final Brand brand;
  const FilteredProducts({Key key, this.brand}) : super(key: key);

  @override
  _FilteredProductsState createState() => _FilteredProductsState();
}

class _FilteredProductsState extends State<FilteredProducts> {
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
          'Thrifters',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 0, 2, 2),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Icon(
                                Icons.sort_sharp,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Text(
                                'sort',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 0, 2, 2),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Icon(
                                Icons.filter_list,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Text(
                                'filter',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      labelColor: Color(0xFF1D9E6A),
                      unselectedLabelColor: Colors.black,
                      labelStyle: FlutterFlowTheme.bodyText1,
                      indicatorColor: Color(0xFF1D9E6A),
                      tabs: [
                        Tab(
                          text: 'Example 1',
                        ),
                        Tab(
                          text: 'Example 2',
                        ),
                        Tab(
                          text: 'Example 3',
                        ),
                        Tab(
                          text: 'Example 4',
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Text(
                            'Tab View 1',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            'Tab View 2',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            'Tab View 3',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            'Tab View 4',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot<Product>>(
// stream: ProductAPI.loadProducts(),
// builder: (context, snapshot) {
// if (snapshot.hasError) {
// return Text('Something went wrong');
// }
//
// if (snapshot.connectionState == ConnectionState.waiting) {
// return Center(child: CircularProgressIndicator());
// }
// List<Product> products = snapshot.data.docs
//     .map((e) => e.data())
//     .where((element) =>
// element.brand.name == widget.brand.name)
//     .toList();
// return ProductsGridView(products: products);
// }),
