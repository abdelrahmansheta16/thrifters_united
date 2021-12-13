import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/OrderAPI.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ChooseAddressWidget extends StatefulWidget {
  final List<Address> addresses;
  ChooseAddressWidget({Key key, this.addresses}) : super(key: key);

  @override
  _ChooseAddressWidgetState createState() => _ChooseAddressWidgetState();
}

class _ChooseAddressWidgetState extends State<ChooseAddressWidget> {
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
              return ListTile(
                leading: Radio<Address>(
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
                  ),
                ),
                subtitle: Column(
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
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF303030),
                  size: 20,
                ),
                tileColor: Color(0xFFF5F5F5),
                dense: false,
                contentPadding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
