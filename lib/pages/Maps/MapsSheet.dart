// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:map_launcher/map_launcher.dart';
//
// class MapsSheet {
//   static show(
//     BuildContext context,
//     Function(AvailableMap map) onMapTap,
//   ) async {
//     final availableMaps = await MapLauncher.installedMaps;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//           decoration: new BoxDecoration(
//             color: Colors.white,
//             borderRadius: new BorderRadius.only(
//               topLeft: const Radius.circular(25.0),
//               topRight: const Radius.circular(25.0),
//             ),
//           ),
//           child: Wrap(
//             children: [
//               for (var map in availableMaps)
//                 ListTile(
//                   onTap: () => onMapTap(map),
//                   title: Text(map.mapName),
//                   leading: SvgPicture.asset(
//                     map.icon,
//                     height: 30.0,
//                     width: 30.0,
//                   ),
//                 ),
//             ],
//           )),
//     );
//   }
// }
