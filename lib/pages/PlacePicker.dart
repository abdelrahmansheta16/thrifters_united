// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:place_picker/entities/entities.dart';
// import 'package:place_picker/widgets/place_picker.dart';
//
// // Your api key storage.
//
// class Gmaps extends StatefulWidget {
//   const Gmaps({Key key}) : super(key: key);
//
//   @override
//   _GmapsState createState() => _GmapsState();
// }
//
// class _GmapsState extends State<Gmaps> {
//   static LocationResult result;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Google Map Place Picer Demo"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 child: Text("Load Google Map"),
//                 onPressed: () async {
//                   result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return PlacePicker(
//                             "AIzaSyB--Qums_5yz-SAwyR40zP71r5a9I3FoRc");
//                       },
//                     ),
//                   );
//                   print(result);
//                 },
//               ),
//             ],
//           ),
//         ));
//   }
// }
