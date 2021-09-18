import 'package:provider/provider.dart';
import 'package:thrifters_united/pages/Authentication/SIGN%20IN.dart';
import 'package:thrifters_united/pages/Authentication/SIGN%20UP.dart';
import '../FirebaseAPI/AuthenticationAPI.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationWidget extends StatefulWidget {
  AuthenticationWidget({Key key}) : super(key: key);

  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  'THRIFTERS',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Raleway',
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            height: 4,
            thickness: 8,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              'Continue with',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    width: 170,
                    height: 44,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              try {
                                await Provider.of<AuthenticationAPI>(context,
                                        listen: false)
                                    .signInWithFacebook();
                              } catch (e) {
                                print(e);
                              }
                              Navigator.pop(context);
                            },
                            text: 'Facebook',
                            icon: Icon(
                              Icons.add,
                              color: Colors.transparent,
                              size: 20,
                            ),
                            options: FFButtonOptions(
                              width: 230,
                              height: 44,
                              color: Colors.white,
                              textStyle: GoogleFonts.getFont(
                                'Roboto',
                                color: Color(0xFF1877F2),
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                              elevation: 4,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(-0.83, 0),
                          child: Container(
                            width: 22,
                            height: 22,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=512&h=512',
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                    width: 170,
                    height: 44,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              try {
                                await Provider.of<AuthenticationAPI>(context,
                                        listen: false)
                                    .signInWithGoogle();
                              } catch (e) {
                                print(e);
                              }
                              Navigator.pop(context);
                            },
                            text: 'Google',
                            icon: Icon(
                              Icons.add,
                              color: Colors.transparent,
                              size: 20,
                            ),
                            options: FFButtonOptions(
                              width: 230,
                              height: 44,
                              color: Colors.white,
                              textStyle: GoogleFonts.getFont(
                                'Roboto',
                                color: Color(0xFF606060),
                                fontSize: 17,
                              ),
                              elevation: 4,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(-0.83, 0),
                          child: Container(
                            width: 22,
                            height: 22,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 3,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Login to your Thrifters account with',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Color(0xFF464646),
                    indicatorColor: Color(0xFF00BFA5),
                    indicatorWeight: 1,
                    tabs: [
                      Tab(
                        text: 'SIGN IN',
                      ),
                      Tab(
                        text: 'SIGN UP',
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [SignIn(), SignUp()],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
