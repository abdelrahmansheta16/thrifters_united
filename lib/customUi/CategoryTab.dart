import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  final String label;

  CategoryTab({Key key, this.label}) : super(key: key);

  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        widget.label,
        style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Style Script',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
