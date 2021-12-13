import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class GuestUser extends StatelessWidget {
  const GuestUser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              'Hi Guest user,',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              'In order to view this information you must be signed in .',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ),
          FFButtonWidget(
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist/authentication');
            },
            text: 'Sign in /Sign up',
            options: FFButtonOptions(
              width: 130,
              height: 40,
              color: Colors.black,
              textStyle: FlutterFlowTheme.subtitle2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: 0,
            ),
          )
        ],
      ),
    );
  }
}
