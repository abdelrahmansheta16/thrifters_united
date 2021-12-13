import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class AccountInfoContainer extends StatefulWidget {
  final USER user;
  const AccountInfoContainer({Key key, this.user}) : super(key: key);

  @override
  State<AccountInfoContainer> createState() => _AccountInfoContainerState();
}

class _AccountInfoContainerState extends State<AccountInfoContainer> {
  String radioButtonValue1;
  String radioButtonValue2;
  TextEditingController firstName;
  TextEditingController secondName;
  bool enableEditing = false;
  final accountFormKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String gender;

  DateTime _birthdate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _birthdate = widget.user.birthday;
    gender = widget.user.gender;
    firstName = TextEditingController(text: widget.user.name);
    secondName = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    return enableEditing ? EnableEditingWidget() : buildColumn(context);
  }

  Column buildColumn(BuildContext context) {
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
                        'Account info',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              enableEditing = true;
                            });
                          },
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'First Name',
                              style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' : ${widget.user.name}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Last Name',
                              style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' : ${widget.user.name}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Gender',
                              style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' : ${widget.user.gender}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Birthday',
                              style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' : ${widget.user.birthday?.day}' +
                                  '/' +
                                  '${widget.user.birthday?.month}' +
                                  '/' +
                                  '${widget.user.birthday?.year}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
        ),
      ],
    );
  }

  Form EnableEditingWidget() {
    return Form(
        key: accountFormKey,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          enableEditing = false;
                        });
                        ;
                      },
                    ),
                    Text(
                      'Phone Number',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    isLoading
                        ? JumpingDotsProgressIndicator(
                            color: Color(0xFF0EA200),
                            fontSize: 30,
                            milliseconds: 0,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.check_sharp,
                              color: Color(0xFF0EA200),
                              size: 25,
                            ),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (accountFormKey.currentState.validate()) {
                                widget.user.name = firstName.text;
                                widget.user.birthday = _birthdate;
                                widget.user.gender = gender;
                                await UserAPI.setUser(user: widget.user);
                                setState(() {
                                  enableEditing = false;
                                });
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                          )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: firstName,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'First name *',
                        labelStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF848484),
                        ),
                        hintText: 'First name *',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF848484),
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
                        suffixIcon: firstName.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => firstName.clear(),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: Color(0xFF757575),
                                  size: 22,
                                ),
                              )
                            : null,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF848484),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This field is required';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: secondName,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Last name *',
                        labelStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF848484),
                        ),
                        hintText: 'Last name *',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF848484),
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
                        suffixIcon: secondName.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => secondName.clear(),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: Color(0xFF757575),
                                  size: 22,
                                ),
                              )
                            : null,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF848484),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This field is required';
                        }

                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Gender',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF848484),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RadioButton(
                            description: "Male",
                            value: "Male",
                            groupValue: gender,
                            onChanged: (value) => setState(
                              () => gender = value,
                            ),
                          ),
                          RadioButton(
                            description: "Female",
                            value: "Female",
                            groupValue: gender,
                            onChanged: (value) => setState(
                              () => gender = value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Birthday',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF848484),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now())
                                .then((value) {
                              setState(() {
                                _birthdate = value;
                              });
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: Text(
                                '  ${_birthdate?.day}' +
                                    '/' +
                                    '${_birthdate?.month}' +
                                    '/' +
                                    '${_birthdate?.year}',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ])));
  }
}
