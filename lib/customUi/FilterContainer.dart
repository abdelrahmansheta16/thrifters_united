import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/FilterProvider.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

class FilterContainer extends StatelessWidget {
  final List<String> filter;
  const FilterContainer({Key key, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: SingleChildScrollView(
        child: filter == null || filter.length == 0
            ? Text('Any')
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.black12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: List.generate(filter?.length, (index) {
                          String currentCategory = filter[index];
                          return Text(
                            currentCategory,
                            style: TextStyle(color: Colors.black),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
