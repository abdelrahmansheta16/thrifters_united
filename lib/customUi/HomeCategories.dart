import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/customUi/FilteredProducts.dart';
import 'package:thrifters_united/customUi/ProductContainer.dart';
import 'package:thrifters_united/customUi/ProductDetails.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';

class HomeCategories extends StatefulWidget {
  final List<String> categoryPath;
  final List<String> parentPath;
  final Category category;
  final String title;
  HomeCategories(
      {Key key, this.categoryPath, this.category, this.title, this.parentPath})
      : super(key: key);

  @override
  _HomeCategoriesState createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, model, child) {
      List<Product> products = model.products.where((element) {
        var productCategory = element.categories;
        var selectedCategory = widget.categoryPath;

        var firstListSet = productCategory.toSet();
        var secondListSet = selectedCategory.toSet();
        return firstListSet.intersection(secondListSet).length ==
            selectedCategory.length;
      }).toList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: FlutterFlowTheme.title2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FilteredProducts(
                                    category: widget.category,
                                    parentCategoryPath: widget.parentPath,
                                    // brand: FilterProvider.of(context,
                                    //         listen: false)
                                    //     .initialBrands
                                    //     .where((element) =>
                                    //         element.name == 'Antonio Banderas')
                                    //     .first,
                                  )),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'see more',
                              style: FlutterFlowTheme.bodyText1,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(products.length, (index) {
                      Product product = products[index];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsWidget(product: product)),
                            );
                          },
                          child: ProductContainer(
                            product: product,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
