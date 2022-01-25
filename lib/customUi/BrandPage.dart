import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'BrandsList.dart';

class BrandPage extends StatefulWidget {
  BrandPage({Key key}) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
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
          'Brands',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('brands')
              .orderBy('name')
              .withConverter<Brand>(
                fromFirestore: (snapshot, _) => Brand.fromJson(snapshot.data()),
                toFirestore: (brand, _) => brand.toJson(),
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<Brand> brands =
                snapshot.data.docs.map((DocumentSnapshot document) {
              Brand brand;
              brand = document.data();
              return brand;
            }).toList();
            return BrandsList(
              brands: brands,
            );
          }),
    );
  }
}
