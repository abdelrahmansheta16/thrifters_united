import 'package:maps_launcher/maps_launcher.dart';
import 'package:thrifters_united/FirebaseAPI/UserAPI.dart';
import 'package:thrifters_classes/thrifters_classes.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final Address address;
  AddressWidget({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String googleUrl =
    //     'comgooglemaps://?center=${address.location.latitude},${address.location.longitude}';
    // String appleUrl =
    //     'https://maps.apple.com/?sll=${address.location.latitude},${address.location.longitude}';
    return InkWell(
      onTap: () async {
        await MapsLauncher.launchCoordinates(
          address.location.latitude,
          address.location.longitude,
          address.addressName,
        );
        // if (await canLaunch("comgooglemaps://")) {
        //   print('launching com googleUrl');
        //   await launch(googleUrl);
        // } else if (await canLaunch(appleUrl)) {
        //   print('launching apple url');
        //   await launch(appleUrl);
        // } else {
        //   throw 'Could not launch url';
        // }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                address?.addressID,
                style: FlutterFlowTheme.title3.override(
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Column(
                children: [
                  Text(
                    address?.phoneNumber,
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    address?.floorNumber,
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () async {
                  await UserAPI.removeAddress(address: address);
                },
                icon: Icon(
                  Icons.close_sharp,
                  color: Color(0xFFC7C7C7),
                  size: 20,
                ),
                iconSize: 20,
              ),
              tileColor: Color(0xFFF5F5F5),
              dense: false,
            ),
            Divider(
              height: 0.1,
              thickness: 0.5,
              color: Color(0xFFAFAFAF),
            )
          ],
        ),
      ),
    );
  }
}
