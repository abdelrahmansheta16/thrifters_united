import 'package:country_code_picker/country_code_picker.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class PhoneNumberContainer extends StatefulWidget {
  final USER user;
  const PhoneNumberContainer({Key key, this.user}) : super(key: key);

  @override
  State<PhoneNumberContainer> createState() => _PhoneNumberContainerState();
}

class _PhoneNumberContainerState extends State<PhoneNumberContainer> {
  MaskedTextController textController;

  bool enableEditing = false;

  var currentCode = '+20';
  var currentSelection = 'eg';

  final phoneFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    textController = MaskedTextController(
        text: widget.user.phoneNumber ?? '', mask: '000-000-0000');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return enableEditing ? EnableEditingWidget() : ValueWidget(context);
  }

  Column ValueWidget(BuildContext context) {
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
                        'Phone Number',
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
                      color: Color(0xFFD7D7D7),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: Text(
                      widget.user.phoneNumber ?? '',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.bodyText1,
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
        )
      ],
    );
  }

  Form EnableEditingWidget() {
    return Form(
      key: phoneFormKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
                  IconButton(
                    icon: Icon(
                      Icons.check_sharp,
                      color: Color(0xFF0EA200),
                      size: 25,
                    ),
                    onPressed: () async {
                      if (phoneFormKey.currentState.validate()) {
                        widget.user.phoneNumber =
                            '${currentCode}-${textController.text}';
                        await UserAPI.setUser(user: widget.user);
                        setState(() {
                          enableEditing = false;
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CountryCodePicker(
                      padding: EdgeInsets.all(0.5),
                      boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      barrierColor: Colors.white,
                      showDropDownButton: true,
                      onChanged: (code) {
                        setState(() {
                          currentCode = code.dialCode;
                          print(code.dialCode);
                        });
                      },
                      initialSelection: currentCode,
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: ['+20'],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: textController,
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
                        print(value);
                        if (value.isEmpty) {
                          return 'Required';
                        } else if (textController.text
                                .split('-')
                                .join()
                                .length !=
                            10) {
                          return '10 digits required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
