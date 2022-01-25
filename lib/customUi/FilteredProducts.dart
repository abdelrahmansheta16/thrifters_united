import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/FirebaseAPI/ProductAPI.dart';
import 'package:thrifters_united/customUi/Filter.dart';
import 'package:thrifters_united/customUi/ProductsGridView.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class FilteredProducts extends StatefulWidget {
  final Brand brand;
  final Category category;
  final List<String> parentCategoryPath;
  const FilteredProducts(
      {Key key, this.brand, this.category, this.parentCategoryPath})
      : super(key: key);

  @override
  _FilteredProductsState createState() => _FilteredProductsState();
}

class _FilteredProductsState extends State<FilteredProducts> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // String currentCategory = 'women';

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FilterProvider.of(context, listen: false).clearSelected();
      if (widget.brand != null) {
        FilterProvider.of(context, listen: false).updateBrands([widget.brand]);
      }
      if (widget.category != null) {
        if (widget.parentCategoryPath.length != 0) {
          FilterProvider.of(context, listen: false).updateCategories(
              List.generate(widget.parentCategoryPath.length + 1, (index) {
            if (index >= widget.parentCategoryPath.length) {
              return widget.category.name;
            }
            return widget.parentCategoryPath[index];
          }));
        }
        // FilterProvider.of(context, listen: false)
        //     .updateCategories([widget.category.name]);
      }
    });
    super.initState();
  }

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
      body: Consumer<FilterProvider>(builder: (context, model, child) {
        return Column(
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.5, 0, 2, 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.5, 0, 2, 2),
                      child: InkWell(
                        onTap: () {
                          showFlexibleBottomSheet(
                            minHeight: 0.5,
                            initHeight: 0.5,
                            maxHeight: 0.8,
                            context: context,
                            isDismissible: true,
                            isCollapsible: false,
                            builder: _buildBottomSheet,
                            anchors: [0.5, 0.8],
                          );
                          // showModalBottomSheet(
                          //   isScrollControlled: true,
                          //   backgroundColor: Colors.transparent,
                          //   context: context,
                          //   builder: (context) => FilterWidget(),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: Icon(
                                    Icons.filter_list,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
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
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: widget.category == null
                    ? 4
                    : widget.category.subCategories.length + 1,
                initialIndex: 0,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFF1D9E6A),
                              width: 1,
                            ),
                          ),
                          onTap: (index) {
                            if (widget.category == null) {
                              switch (index) {
                                case 0:
                                  model.updateCategories([]);
                                  break;
                                case 1:
                                  model.updateCategories(['men']);
                                  break;
                                case 2:
                                  model.updateCategories(['women']);
                                  break;
                                case 3:
                                  model.updateCategories(['kids']);
                                  break;
                                default:
                                  model.updateCategories([]);
                              }
                            } else {
                              List.generate(
                                  widget.category.subCategories.length + 1,
                                  (ind) {
                                if (index == 0) {
                                  model.updateCategories(getCategoryPath(
                                      widget.parentCategoryPath,
                                      [widget.category.name]));
                                } else {
                                  Category currentCategory =
                                      widget.category.subCategories[index - 1];
                                  model.updateCategories(getCategoryPath(
                                      widget.parentCategoryPath, [
                                    widget.category.name,
                                    currentCategory.name
                                  ]));
                                }
                                return ProductsGridView();
                              });
                            }
                          },
                          // onTap: (index) {
                          //   switch (index) {
                          //     case 0:
                          //       currentCategory = 'women';
                          //       FilterProvider.of(context, listen: false)
                          //           .updateCategories([]);
                          //       break;
                          //     case 1:
                          //       currentCategory = 'men';
                          //       FilterProvider.of(context, listen: false)
                          //           .updateCategories([currentCategory]);
                          //       break;
                          //     case 2:
                          //       currentCategory = 'women';
                          //       FilterProvider.of(context, listen: false)
                          //           .updateCategories([currentCategory]);
                          //       break;
                          //     case 3:
                          //       currentCategory = 'kids';
                          //       FilterProvider.of(context, listen: false)
                          //           .updateCategories([currentCategory]);
                          //       break;
                          //     default:
                          //       currentCategory = 'women';
                          //       FilterProvider.of(context, listen: false)
                          //           .updateCategories([currentCategory]);
                          //   }
                          // },
                          isScrollable: true,
                          labelColor: Color(0xFF1D9E6A),
                          unselectedLabelColor: Colors.black,
                          labelStyle: FlutterFlowTheme.bodyText1,
                          indicatorColor: Color(0xFF1D9E6A),
                          tabs: widget.category == null
                              ? [
                                  Tab(
                                    child: Text(
                                      'All',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Men',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Women',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Kids',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ]
                              : List.generate(
                                  widget.category.subCategories.length + 1,
                                  (index) {
                                  if (index == 0) {
                                    return Tab(
                                      child: Text(
                                        'All ${widget.category.name}',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }
                                  return Tab(
                                    child: Text(
                                      '${widget.category.subCategories[index - 1].name}',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  );
                                })),
                    ),
                    Expanded(
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: widget.category == null
                              ? List.generate(4, (index) {
                                  return ProductsGridView();
                                })
                              : List.generate(
                                  widget.category.subCategories.length + 1,
                                  (index) {
                                  return ProductsGridView();
                                })),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  List<String> getCategoryPath(
    List<String> parentCategoryPath,
    List<String> currentCategoryPath,
  ) {
    List<String> path = [];
    if (parentCategoryPath != null && parentCategoryPath.length != 0) {
      path.addAll(parentCategoryPath);
    }
    path.addAll(currentCategoryPath);
    return path;
  }

  // List<Product> getProducts(String categoryName, List<Product> products) {
  //   List<Product> selectedProducts = [];
  //   for (Product product in products) {
  //     if (product.categories[0] == categoryName) {
  //       selectedProducts.add(product);
  //     }
  //   }
  //   return selectedProducts;
  // }
}

Widget _buildBottomSheet(
  BuildContext context,
  ScrollController scrollController,
  double bottomSheetOffset,
) {
  return FilterWidget(
    scrollController: scrollController,
  );
}

// List<String> names = products
//     .map((e) => e.categories.map((e) => e.name).toString())
//     .toList();
// Category category = ProductAPI.getParentCategory(names);
// if (names.contains(category)) {
// String name =
// names.where((element) => names.contains(category)).toString();
// selectedCategories.add(category);
// }
// category.subCategories.forEach((first) {
// if (names.contains(first.name)) {
// selectedCategories.add(first);
// }
// if (first.subCategories.length != 0) {
// first.subCategories.forEach((element) {
// getProducts(element, names);
// });
// }
// });
//
// selectedCategories.toSet().toList();
// selectedCategories.forEach((first) {
// print(first.name);
// first.products.forEach((second) {
// products.add(second);
// });
// });

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
