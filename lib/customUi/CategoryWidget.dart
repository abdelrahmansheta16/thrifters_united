import 'package:flutter/material.dart';
import 'package:thrifters_united/main.dart';

class CategoryWidget extends StatefulWidget {
  final String imageUrl;
  final String label;

  CategoryWidget({Key key, this.imageUrl, this.label}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 60,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              widget.imageUrl,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                );
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                    color: Colors.black12,
                  ),
                );
              },
            ),
          ),
        ),
        Text(
          widget.label,
          style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
