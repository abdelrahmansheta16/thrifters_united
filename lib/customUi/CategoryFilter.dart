// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:thrifters_united/FirebaseAPI/ProductAPI.dart';
// import 'package:thrifters_united/customUi/ChooseCategory.dart';
// import 'package:thrifters_united/models/Category.dart';
//
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CategoryFilter extends StatefulWidget {
//   CategoryFilter({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _CategoryFilterState createState() => _CategoryFilterState();
// }
//
// class _CategoryFilterState extends State<CategoryFilter> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         automaticallyImplyLeading: true,
//         title: Text(
//           'Categories',
//           style: FlutterFlowTheme.bodyText1.override(
//             fontFamily: 'Poppins',
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         actions: [],
//         centerTitle: true,
//         elevation: 1,
//       ),
//       backgroundColor: Colors.white,
//       body: StreamBuilder<QuerySnapshot<Category>>(
//           stream: ProductAPI.loadCategories(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }
//
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//             Category women;
//             women = snapshot.data.docs
//                 .where((element) => element.id == 'women')
//                 .first
//                 .data();
//             Category men;
//             men = snapshot.data.docs
//                 .where((element) => element.id == 'men')
//                 .first
//                 .data();
//             Category kids;
//             kids = snapshot.data.docs
//                 .where((element) => element.id == 'kids')
//                 .first
//                 .data();
//             return DefaultTabController(
//               length: 3,
//               initialIndex: 0,
//               child: Column(
//                 children: [
//                   TabBar(
//                     labelColor: Color(0xFF1D9E6A),
//                     unselectedLabelColor: Colors.black,
//                     labelStyle: FlutterFlowTheme.bodyText1.override(
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w600,
//                     ),
//                     indicatorColor: Color(0xFF1D9E6A),
//                     tabs: [
//                       Tab(
//                         text: 'Women',
//                       ),
//                       Tab(
//                         text: 'Men',
//                       ),
//                       Tab(
//                         text: 'Kids',
//                       )
//                     ],
//                   ),
//                   Divider(
//                     height: 1.5,
//                     thickness: 1.0,
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       physics: NeverScrollableScrollPhysics(),
//                       children: [
//                         ChooseCategory(category: women),
//                         ChooseCategory(category: men),
//                         ChooseCategory(category: kids),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
