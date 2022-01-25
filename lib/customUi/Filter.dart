import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/customUi/BrandsList.dart';
import 'package:thrifters_united/customUi/CategoryFilter.dart';
import 'package:thrifters_united/customUi/ChooseCategory.dart';
import 'package:thrifters_united/customUi/FilterContainer.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'CategoryContainer.dart';

class FilterWidget extends StatefulWidget {
  final ScrollController scrollController;
  FilterWidget({Key key, this.scrollController}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // return makeDismissible(
    //   child: DraggableScrollableSheet(
    //     initialChildSize: 0.5,
    //     maxChildSize: 0.8,
    //     minChildSize: 0.5,
    //     builder: (_, controller) =>
    return SafeArea(
      child: Material(
        child: Consumer<FilterProvider>(builder: (context, model, child) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  // controller: controller,
                  controller: widget.scrollController,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    ListTile(
                      title: Text(
                        'Filters',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      trailing: TextButton(
                        onPressed: model.sizes.length != 0 ||
                                model.selectedCategory.length != 0 ||
                                model.selectedPriceRanges.length != 0 ||
                                model.selectedBrands.length != 0
                            ? () {
                                FilterProvider.of(context, listen: false)
                                    .clearSelected();
                              }
                            : null,
                        child: Text(
                          'Clear All',
                        ),
                      ),
                      tileColor: Colors.white,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CategoryFilter(
                                    category: model.selectedCategory,
                                  )),
                        );
                      },
                      title: Text(
                        'Category',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      subtitle: CategoryContainer(
                        category: model.selectedCategory,
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BrandsList(
                                    brands:
                                        model.initialBrands.where((element) {
                                      return model.filteredProducts.any(
                                          (product) =>
                                              product.brand.name ==
                                              element.name);
                                    }).toList(),
                                  )),
                        );
                      },
                      title: Text(
                        'Brand',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      tileColor: Colors.white,
                      subtitle: FilterContainer(
                        filter:
                            model.selectedBrands?.map((e) => e.name)?.toList(),
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
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      subtitle: FilterContainer(
                        filter: model.color,
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BrandsList(
                                    size: model.initialSizes.where((element) {
                                      return model.filteredProducts.any(
                                          (product) =>
                                              product.size.name ==
                                              element.name);
                                    }).toList(),
                                  )),
                        );
                      },
                      title: Text(
                        'Size',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      subtitle: FilterContainer(
                        filter: model.sizes.map((e) => e.name).toList(),
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => BrandsList(
                                    range: model.initialPriceRanges,
                                  )),
                        );
                      },
                      title: Text(
                        'Price',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      subtitle: FilterContainer(
                        filter: model.selectedPriceRanges.map((range) {
                          String updatedRange = range.max != null
                              ? '${range.min.toString()} EGP - ${range.max.toString()} EGP'
                              : 'Above ${range.min} EGP';
                          return updatedRange;
                        }).toList(),
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
                        style: FlutterFlowTheme.subtitle2,
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
                        style: FlutterFlowTheme.subtitle2,
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
                        style: FlutterFlowTheme.subtitle2,
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
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('show results'),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget makeDismissible({Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      onVerticalDragStart: (_) {},
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
