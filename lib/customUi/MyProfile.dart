import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class MyProfileContainer extends StatelessWidget {
  final Widget widget;
  final String string;
  const MyProfileContainer({Key key, this.widget, this.string})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        string,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFB6B6B6),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: widget,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 12,
          thickness: 10,
          color: Color(0xFFDEDEDE),
        )
      ],
    );
  }
}
