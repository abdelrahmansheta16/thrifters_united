import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/customUi/FilteredProducts.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';

class HomeBrands extends StatefulWidget {
  const HomeBrands({Key key}) : super(key: key);

  @override
  _HomeBrandsState createState() => _HomeBrandsState();
}

class _HomeBrandsState extends State<HomeBrands> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, model, child) {
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
                      'Top Brands',
                      style: FlutterFlowTheme.title2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FilteredProducts(
                                    // category:
                                    //     FilterProvider.of(context, listen: false)
                                    //         .initialCategories[2]
                                    //         .subCategories
                                    //         .where((element) =>
                                    //             element.name == 'Clothing')
                                    //         .first,
                                    parentCategoryPath: ['women'],
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
                    children:
                        List.generate(model.initialBrands.length, (index) {
                      Brand brand = model.initialBrands[index];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => FilteredProducts(
                                        brand: FilterProvider.of(context,
                                                listen: false)
                                            .initialBrands
                                            .where((element) =>
                                                element.name == brand.name)
                                            .first,
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 4)),
                            child: Image.network(
                              brand.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
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
