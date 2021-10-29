// import 'package:flutter/material.dart';
// import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
// import 'package:thrifters_united/models/Category.dart';
//
// class ChooseCategory extends StatefulWidget {
//   final Category category;
//   const ChooseCategory({
//     Key key,
//     @required this.category,
//   }) : super(key: key);
//
//   @override
//   State<ChooseCategory> createState() => _ChooseCategoryState();
// }
//
// class _ChooseCategoryState extends State<ChooseCategory> {
//   List<Category> selectedCategories = [];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemBuilder: (context, index) {
//         Category currentCategory = widget.category.subCategories[index];
//         return buildExpansionTile(currentCategory);
//       },
//       separatorBuilder: (context, index) => Container(
//         color: Colors.white60,
//         height: 1,
//         width: MediaQuery.of(context).size.width,
//       ),
//       itemCount: widget.category.subCategories.length,
//     );
//   }
//
//   Widget buildExpansionTile(Category currentCategory) {
//     if (currentCategory.subCategories.length == 0) {
//       return ListTile(
//         selected: currentCategory.isSelected,
//         onTap: () {
//           setState(() {
//             currentCategory.isSelected = !currentCategory.isSelected;
//           });
//           getSelectedCategories();
//         },
//         title: Padding(
//           padding: EdgeInsets.only(left: getPadding(currentCategory)),
//           child: Text(
//             currentCategory.name,
//             style: getStyle(currentCategory),
//           ),
//         ),
//         trailing: currentCategory.isSelected
//             ? Icon(
//                 Icons.check_sharp,
//                 color: Color(0xFF1D9E6A),
//               )
//             : Icon(Icons.keyboard_arrow_right_sharp),
//       );
//     }
//     return ExpansionTile(
//       title: Padding(
//         padding: EdgeInsets.only(left: getPadding(currentCategory)),
//         child: Text(
//           currentCategory.name,
//           style: getStyle(currentCategory),
//         ),
//       ),
//       trailing: currentCategory.subCategories.length == 0
//           ? Icon(Icons.keyboard_arrow_right_sharp)
//           : currentCategory.isExpanded
//               ? Icon(Icons.keyboard_arrow_up_sharp)
//               : Icon(Icons.keyboard_arrow_down_sharp),
//       children: List.generate(currentCategory.subCategories.length, (index) {
//         Category subCategory = currentCategory.subCategories[index];
//         if (subCategory.subCategories.length == 0) {
//           return ListTile(
//             selected: subCategory.isSelected,
//             onTap: () {
//               setState(() {
//                 subCategory.isSelected = !subCategory.isSelected;
//               });
//               getSelectedCategories();
//             },
//             title: Padding(
//               padding: EdgeInsets.only(left: getPadding(subCategory)),
//               child: Text(
//                 subCategory.name,
//                 style: getStyle(subCategory),
//               ),
//             ),
//             trailing: subCategory.isSelected
//                 ? Icon(
//                     Icons.check_sharp,
//                     color: Color(0xFF1D9E6A),
//                   )
//                 : Icon(Icons.keyboard_arrow_right_sharp),
//           );
//         }
//         return buildExpansionTile(subCategory);
//       }),
//       onExpansionChanged: (bool expanded) {
//         setState(() {
//           currentCategory.isExpanded = expanded;
//         });
//       },
//     );
//   }
//
//   double getPadding(Category currentCategory) {
//     switch (currentCategory.level) {
//       case -1:
//         return 0;
//         break;
//       case 0:
//         return 0;
//         break;
//       case 1:
//         return 15;
//         break;
//       case 2:
//         return 30;
//         break;
//       default:
//         0;
//     }
//     return 0;
//   }
//
//   TextStyle getStyle(Category currentCategory) {
//     switch (currentCategory.level) {
//       case -1:
//         return FlutterFlowTheme.bodyText1.override(
//           color: currentCategory.isSelected ? Color(0xFF1D9E6A) : Colors.black,
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//         );
//         break;
//       case 0:
//         return FlutterFlowTheme.bodyText1.override(
//           color: currentCategory.isSelected ? Color(0xFF1D9E6A) : Colors.black,
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//         );
//         break;
//       case 1:
//         return FlutterFlowTheme.bodyText1.override(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//           color:
//               currentCategory.isSelected ? Color(0xFF1D9E6A) : Colors.black38,
//         );
//         break;
//       case 2:
//         return FlutterFlowTheme.bodyText1.override(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w400,
//           fontSize: 14,
//           color: currentCategory.isSelected ? Color(0xFF1D9E6A) : Colors.black,
//         );
//         break;
//       default:
//         FlutterFlowTheme.bodyText1.override(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//         );
//     }
//     return FlutterFlowTheme.bodyText1.override(
//       fontFamily: 'Poppins',
//       fontWeight: FontWeight.w600,
//     );
//   }
//
//   void getSelectedCategories() {
//     selectedCategories.clear();
//     extractSelected(widget.category);
//     selectedCategories.forEach((element) {
//       print(element.name);
//     });
//   }
//
//   void extractSelected(Category category) {
//     category.subCategories.forEach((element) {
//       if (element.isSelected) {
//         selectedCategories.add(element);
//       }
//       if (element.subCategories.length != 0) {
//         element.subCategories.forEach((element) {
//           extractSelected(element);
//         });
//       }
//     });
//   }
// }
