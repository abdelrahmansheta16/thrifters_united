// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// import 'package:thrifters_classes/thrifters_classes.dart' as th;
// import 'package:flutter/material.dart';
// import 'package:thrifters_classes/utils.dart';
// import 'package:thrifters_united/customUi/FilteredProducts.dart';
//
// class SearchProductWidget extends StatefulWidget {
//   const SearchProductWidget({Key key}) : super(key: key);
//
//   @override
//   _SearchProductWidgetState createState() => _SearchProductWidgetState();
// }
//
// class _SearchProductWidgetState extends State<SearchProductWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Flexible(
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.close,
//                           color: Colors.black,
//                           size: 30,
//                         ),
//                         onPressed: () {
//                           print('IconButton pressed ...');
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Flexible(flex: 3, child: TypeAheadWidget()),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TypeAheadWidget extends StatelessWidget {
//   const TypeAheadWidget({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<th.Brand>(
//       textFieldConfiguration: TextFieldConfiguration(
//         style: DefaultTextStyle.of(context)
//             .style
//             .copyWith(fontStyle: FontStyle.italic),
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'Search by Brand',
//         ),
//       ),
//       minCharsForSuggestions: 1,
//       noItemsFoundBuilder: (context) {
//         return Text('No Brands Found');
//       },
//       errorBuilder: (context, object) {
//         return Text('error searching for brand');
//       },
//       suggestionsCallback: (pattern) {
//         return Utils.getSuggestions(pattern);
//       },
//       onSuggestionSelected: (th.Brand suggestion) {
//         // print(suggestion.name);
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => FilteredProducts()),
//         );
//       },
//       itemBuilder: (BuildContext context, th.Brand itemData) {
//         return Container(
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Text(
//                   itemData.name,
//                   style: TextStyle(fontSize: 12),
//                 ),
//               ),
//               Container(
//                 height: 1,
//                 color: Color(0xFFD2D2D2),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
