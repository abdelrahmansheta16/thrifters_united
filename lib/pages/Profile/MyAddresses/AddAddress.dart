import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AddressAPI.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_drop_down_template.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_theme.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAddress extends StatefulWidget {
  AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String buildingType;
  TextEditingController area;
  TextEditingController streetName;
  TextEditingController buildingNo;
  TextEditingController floorNo;
  TextEditingController appartmentNo;
  TextEditingController addressName;
  TextEditingController Landmark;
  TextEditingController PhoneNumber;
  TextEditingController LandLine;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static List<String> BuildingType = [
    'Apartment',
    'Villa',
    'Office',
  ];

  @override
  void initState() {
    super.initState();
    area = TextEditingController();
    streetName = TextEditingController();
    buildingNo = TextEditingController();
    floorNo = TextEditingController();
    appartmentNo = TextEditingController();
    addressName = TextEditingController();
    Landmark = TextEditingController();
    PhoneNumber = TextEditingController();
    LandLine = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // final String userID = ModalRoute.of(context).settings.arguments.toString();
    GeoPoint geoPoint = Provider.of<AddressAPI>(context).geoPoint;
    print(geoPoint);
    var currentCode = '+20';
    // print(userID);
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.black),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            'Address',
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                  child: InkWell(
                    onTap: ()async {
                      await Navigator.pushNamed(context,
                          '/profile/MyAddresses/AddAddress/Maps',
                          arguments:
                          FirebaseAuth.instance.currentUser.uid);
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/googlemaps.jpg',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.pushNamed(context,
                                    '/profile/MyAddresses/AddAddress/Maps',
                                    arguments:
                                        FirebaseAuth.instance.currentUser.uid);
                              },
                              text: 'Add Location',
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
                                  width: 1,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: area,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Area',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'Area',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: streetName,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Street name',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'Street name',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                FlutterFlowDropDown(
                  options: BuildingType.toList(),
                  onChanged: (val) => setState(() => buildingType = val),
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
                  margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                ),
                TextFormField(
                  controller: buildingNo,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Building name\\number',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'Building name\\number',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: floorNo,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'floor number',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'floor number',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: appartmentNo,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Apartment number',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'Apartment number',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: addressName,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Address name(my appartment\\my office\\etc)',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: Landmark,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'Landmark',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Required';
                    }

                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: CountryCodePicker(
                          padding: const EdgeInsets.all(0),
                          showDropDownButton: true,
                          onChanged: (code) {
                            setState(() {
                              currentCode = code.code;
                              print(code.dialCode);
                            });
                          },
                          initialSelection: 'eg',
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          favorite: ['+20'],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: TextFormField(
                          controller: PhoneNumber,
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                            ),
                            hintText: 'Phone Number',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
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
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else if (value.length < 10) {
                              return 'Too short for a phone number!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: LandLine,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Landline number (optional)',
                    labelStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    hintText: 'Landline number (optional)',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
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
                  ),
                  keyboardType: TextInputType.phone,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        print(PhoneNumber.text);
                        Address address = Address(
                          area: area.text,
                          streetName: streetName.text,
                          buildingName: buildingNo.text,
                          floorNumber: floorNo.text,
                          buildingType: buildingType,
                          location: geoPoint,
                          addressName: addressName.text,
                          apartmentNumber: appartmentNo.text,
                          phoneNumber: currentCode + PhoneNumber.text,
                          landline: LandLine.text,
                          landmark: Landmark.text,
                        );
                        if (address.location != null) {
                          print(address.location);
                          await AddressAPI.addAddresses(
                              address, FirebaseAuth.instance.currentUser.uid);
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please choose a location');
                        }

                        // await FirebaseAuth.instance.verifyPhoneNumber(
                        //   phoneNumber: currentCode + PhoneNumber.text,
                        //   verificationCompleted:
                        //       (PhoneAuthCredential credential) {
                        //     Navigator.pop(context);
                        //   },
                        //   verificationFailed: (FirebaseAuthException e) {
                        //     print(e);
                        //   },
                        //   codeSent: (String verificationId, int resendToken) {},
                        //   codeAutoRetrievalTimeout: (String verificationId) {},
                        // );
                      }
                    },
                    text: 'Save address',
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
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
