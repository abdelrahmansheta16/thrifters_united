import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/pages/Authentication/SIGN%20IN.dart';
import 'package:thrifters_united/pages/Authentication/SIGN%20UP.dart';
import '../FirebaseAPI/AuthenticationAPI.dart';
import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Mainscreen.dart';

class AuthenticationWidget extends StatefulWidget {
  AuthenticationWidget({Key key}) : super(key: key);

  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController EmailController;
  TextEditingController PasswordController;
  bool passwordVisibility;
  final _formKey1 = GlobalKey<FormState>();
  bool authenticationShowSpinner = false;
  String selectedValue;
  List<String> items = [
    'Gender',
    'Male',
    'Female',
  ];
  TextEditingController FirstName;
  TextEditingController LastName;
  TextEditingController EmailAddress;
  TextEditingController Password;
  bool checkboxListTileValue;
  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FirstName = TextEditingController();
    LastName = TextEditingController();
    EmailAddress = TextEditingController();
    Password = TextEditingController();
    passwordVisibility = false;
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
    EmailController.dispose();
    PasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'THRIFTERS',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Raleway',
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Color(0xff51c0a9),
        ),
        inAsyncCall: authenticationShowSpinner,
        child: Column(
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
                                setState(() {
                                  authenticationShowSpinner = true;
                                });
                                try {
                                  await Provider.of<AuthenticationAPI>(context,
                                          listen: false)
                                      .signInWithFacebook();
                                } catch (e) {
                                  print(e);
                                }
                                Navigator.pop(context);
                                setState(() {
                                  authenticationShowSpinner = false;
                                });
                                // final BottomNavigationBar navigationBar =
                                //     globalKey.currentWidget;
                                // navigationBar.onTap(0);
                              },
                              text: 'Facebook',
                              icon: Icon(
                                EvaIcons.plus,
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
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Container();
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
                                      color: Colors.black,
                                    ),
                                  );
                                },
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
                                setState(() {
                                  authenticationShowSpinner = true;
                                });
                                try {
                                  await Provider.of<AuthenticationAPI>(context,
                                          listen: false)
                                      .signInWithGoogle();
                                } catch (e) {
                                  print(e);
                                }
                                Navigator.pop(context);
                                setState(() {
                                  authenticationShowSpinner = false;
                                });
                                // final BottomNavigationBar navigationBar =
                                //     globalKey.currentWidget;
                                // navigationBar.onTap(0);
                              },
                              text: 'Google',
                              icon: Icon(
                                EvaIcons.plus,
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
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Container(
                                    width: 22,
                                    height: 22,
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
                                      color: Colors.black,
                                    ),
                                  );
                                },
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
                        children: [
                          Form(
                            key: _formKey1,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: TextFormField(
                                      controller: EmailController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Email address',
                                        labelStyle:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                        ),
                                        hintText: 'Email address',
                                        hintStyle:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF808080),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Please input a valid email adress';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: TextFormField(
                                      controller: PasswordController,
                                      obscureText: !passwordVisibility,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Password',
                                        labelStyle:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                        ),
                                        hintText: 'Password',
                                        hintStyle:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF808080),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => passwordVisibility =
                                                !passwordVisibility,
                                          ),
                                          child: Icon(
                                            passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Color(0xFF757575),
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF808080),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Please input a valid password';
                                        }
                                        if (val.length < 8) {
                                          return 'minimum required characters are 8';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (_formKey1.currentState.validate()) {
                                          try {
                                            setState(() {
                                              authenticationShowSpinner = true;
                                            });
                                            await Provider.of<
                                                        AuthenticationAPI>(
                                                    context,
                                                    listen: false)
                                                .signInWithEmailAndPassword(
                                                    EmailController.text,
                                                    PasswordController.text);
                                            setState(() {
                                              authenticationShowSpinner = false;
                                            });
                                            Navigator.pop(context);
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    SnackBar(content: Text(e)));
                                          }
                                          EmailController.clear();
                                          PasswordController.clear();
                                          final BottomNavigationBar
                                              navigationBar =
                                              globalKey.currentWidget;
                                          navigationBar.onTap(0);
                                        }
                                      },
                                      text: 'SIGN IN',
                                      options: FFButtonOptions(
                                        width: 130,
                                        height: 40,
                                        color: Color(0xFF00BFA5),
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Text(
                                      'Forgot password?',
                                      textAlign: TextAlign.center,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Email support',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF5C5C5C),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Call us',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF4F4F4F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Hello World',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        ),
                                        Text(
                                          'Hello World',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey2,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextFormField(
                                          controller: FirstName,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'First name*',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            hintText: 'First name*',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF808080),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: LastName,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Last name*',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            hintText: 'Last name*',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF808080),
                                          ),
                                        ),
                                        TextFormField(
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'Please input a valid email address';
                                            }

                                            return null;
                                          },
                                          controller: EmailAddress,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Email adress',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            hintText: 'Email adress',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF808080),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        TextFormField(
                                          controller: Password,
                                          obscureText: !passwordVisibility,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'Please input a valid password';
                                            }
                                            if (val.length < 8) {
                                              return 'minimum required charachters are 8';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                () => passwordVisibility =
                                                    !passwordVisibility,
                                              ),
                                              child: Icon(
                                                passwordVisibility
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: Color(0xFF757575),
                                                size: 22,
                                              ),
                                            ),
                                            labelText: 'Password',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            hintText: 'Password',
                                            hintStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF808080),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF808080),
                                          ),
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            hint: Text(
                                              'Select Gender',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: items
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = value as String;
                                              });
                                            },
                                            buttonHeight: 40,
                                            buttonWidth: 140,
                                            itemHeight: 40,
                                          ),
                                        ),
                                        CheckboxListTile(
                                          value: checkboxListTileValue ??= true,
                                          onChanged: (newValue) => setState(
                                              () => checkboxListTileValue =
                                                  newValue),
                                          title: Text(
                                            'Subscribe to news letter and get latest sales',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.title3
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF8D8D8D),
                                              fontSize: 12,
                                            ),
                                          ),
                                          tileColor: Colors.white,
                                          dense: false,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            if (_formKey2.currentState
                                                .validate()) {
                                              try {
                                                setState(() {
                                                  authenticationShowSpinner =
                                                      true;
                                                });
                                                await Provider.of<
                                                            AuthenticationAPI>(
                                                        context,
                                                        listen: false)
                                                    .registerWithEmailandPassword(
                                                  EmailAddress.text,
                                                  Password.text,
                                                  FirstName.text,
                                                  LastName.text,
                                                  selectedValue,
                                                );
                                                setState(() {
                                                  authenticationShowSpinner =
                                                      false;
                                                });
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(e.toString())));
                                              }
                                              EmailAddress.clear();
                                              Password.clear();
                                              Navigator.pop(context);
                                            }
                                          },
                                          text: 'SIGN UP',
                                          options: FFButtonOptions(
                                            width: 130,
                                            height: 40,
                                            color: Color(0xFF00BFA5),
                                            textStyle: FlutterFlowTheme
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: 0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 20, 0, 20),
                                          child: Text(
                                            'By joining you agree with our Terms and Privacy Policy',
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF6B6B6B),
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Email support',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF5C5C5C),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Call us',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF5C5C5C),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Hello World',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        ),
                                        Text(
                                          'Hello World',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF8D8D8D),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
