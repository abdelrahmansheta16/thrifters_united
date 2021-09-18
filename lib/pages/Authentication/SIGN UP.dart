import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AuthenticationAPI.dart';
import 'package:thrifters_united/Screens/Mainscreen.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String dropDownValue;
  TextEditingController FirstName;
  TextEditingController LastName;
  TextEditingController EmailAddress;
  TextEditingController Password;
  bool checkboxListTileValue;
  bool passwordVisibility;
  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FirstName = TextEditingController();
    LastName = TextEditingController();
    EmailAddress = TextEditingController();
    Password = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: FirstName,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'First name*',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF808080),
                      ),
                      hintText: 'First name*',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
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
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF808080),
                    ),
                  ),
                  TextFormField(
                    controller: LastName,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Last name*',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF808080),
                      ),
                      hintText: 'Last name*',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
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
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF808080),
                    ),
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please input a valid email adress';
                      }

                      return null;
                    },
                    controller: EmailAddress,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email adress',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF808080),
                      ),
                      hintText: 'Email adress',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
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
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF808080),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                          () => passwordVisibility = !passwordVisibility,
                        ),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF808080),
                      ),
                      hintText: 'Password',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
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
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF808080),
                    ),
                  ),
                  FlutterFlowDropDown(
                    initialOption: 'Gender',
                    options: ['Gender', 'Male', 'Female'],
                    onChanged: (value) {
                      setState(() => dropDownValue = value);
                    },
                    width: 130,
                    height: 40,
                    textStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    elevation: 2,
                    borderColor: Colors.transparent,
                    borderWidth: 0,
                    borderRadius: 0,
                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                    hidesUnderline: true,
                  ),
                  CheckboxListTile(
                    value: checkboxListTileValue ??= true,
                    onChanged: (newValue) =>
                        setState(() => checkboxListTileValue = newValue),
                    title: Text(
                      'Subscribe to news letter and get latest sales',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF8D8D8D),
                        fontSize: 12,
                      ),
                    ),
                    tileColor: Colors.white,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      if (_formKey2.currentState.validate()) {
                        try {
                          await Provider.of<AuthenticationAPI>(context,
                                  listen: false)
                              .registerWithEmailandPassword(
                                  EmailAddress.text, Password.text);
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e)));
                        }
                        EmailAddress.clear();
                        Password.clear();
                        final BottomNavigationBar navigationBar =
                            globalKey.currentWidget;
                        navigationBar.onTap(0);
                      }
                    },
                    text: 'SIGN UP',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: Color(0xFF00BFA5),
                      textStyle: FlutterFlowTheme.subtitle2.override(
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
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      'By joining you agree with our Terms and Privacy Policy',
                      style: FlutterFlowTheme.bodyText1.override(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email support',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF5C5C5C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Call us',
                    style: FlutterFlowTheme.bodyText1.override(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Hello World',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF8D8D8D),
                    ),
                  ),
                  Text(
                    'Hello World',
                    style: FlutterFlowTheme.bodyText1.override(
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
    );
  }
}
