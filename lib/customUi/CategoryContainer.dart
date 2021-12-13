import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class CategoryContainer extends StatelessWidget {
  final List<dynamic> list;
  const CategoryContainer({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, model, child) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: list == null || list.length == 0
                ? [
                    Text('Any'),
                  ]
                : List.generate(list?.length, (index) {
                    Category category = list[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                            child: Text(
                              category.name ?? 'Any',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
          ),
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }
}
