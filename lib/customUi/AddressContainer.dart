import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AddressAPI.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_classes/thrifters_classes.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_united/flutter_flow/flutter_flow_widgets.dart';
import 'package:thrifters_united/pages/Shopping/ChooseAddress.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AddressContainer extends StatefulWidget {
  final List<Address> addresses;
  AddressContainer({Key key, this.addresses}) : super(key: key);

  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.addresses.map((address) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Consumer<OrderAPI>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  setState(() {
                    value.address = address;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12)),
                  child: ListTile(
                    leading: Radio<Address>(
                      activeColor: Colors.black,
                      value: address,
                      groupValue: value.address,
                      onChanged: (Address address) {
                        setState(() {
                          value.address = address;
                        });
                      },
                    ),
                    title: Text(
                      address.addressID,
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.streetName,
                          style: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          address.floorNumber,
                          style: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AddressAlertDialog(
                              address: address,
                            );
                          },
                        );

                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) => chooseAddress(
                        //       userID: FirebaseAuth.instance.currentUser.uid,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          EvaIcons.trash2Outline,
                          color: Color(0xFF303030),
                          size: 25,
                        ),
                      ),
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    dense: false,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

class AddressAlertDialog extends StatelessWidget {
  final Address address;
  const AddressAlertDialog({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
              child: Text(
                'Are you sure you want to delete this address?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    await Navigator.pop(context);
                  },
                  text: 'Exit',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFF03CE9F),
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await UserAPI.removeAddress(address: address);
                    await Navigator.pop(context);
                  },
                  text: 'Delete',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: Color(0xFF03CE9F),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
