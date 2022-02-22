import 'package:flutter/material.dart';
import 'package:googleapis/adsense/v1_4.dart';
import 'package:thrifters_united/Screens/Mainscreen.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({Key key}) : super(key: key);

  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f7),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://www.pngitem.com/pimgs/m/82-828844_empty-cart-icon-png-transparent-png.png',
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    );
                  },
                  loadingBuilder: (BuildContext context,
                      Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress
                            .expectedTotalBytes !=
                            null
                            ? loadingProgress
                            .cumulativeBytesLoaded /
                            loadingProgress
                                .expectedTotalBytes
                            : null,
                        color: Colors.black12,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 8),
              child: Text(
                'Unfortunately, Your Cart is Empty',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.title2.override(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Text(
                'Please Add Something in your Cart',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1,
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                final BottomNavigationBar navigationBar =
                    globalKey.currentWidget;
                navigationBar.onTap(0);
              },
              text: 'Continue Shopping',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: Colors.white,
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
