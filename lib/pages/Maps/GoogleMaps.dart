import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thrifters_united/FirebaseAPI/AddressAPI.dart';
import 'package:thrifters_united/FirebaseAPI/LocationProvider.dart';
import 'package:thrifters_united/pages/Maps/MapsAPI.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String userId;
  static Position position;
  Completer<GoogleMapController> _mapController = Completer();
  bool isCameraMoving = false;

  static CameraPosition _cameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position?.latitude, position?.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  Future<void> getMyCurrentLocation() async {
    position = await MapsAPI.determinePosition().whenComplete(() async {
      setState(() {});
    });
    LocationProvider.of(context, listen: false)
        .setLastIdleLocation(LatLng(position.latitude, position.longitude));
  }

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Widget buildMap() {
    return Consumer<LocationProvider>(
      builder: (context, currentPosition, child) {
        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              onCameraMove: (CameraPosition position) {
                _cameraPosition = position;
                LocationProvider.of(context, listen: false)
                    .setLastIdleLocation(position.target);
                setState(() {
                  isCameraMoving = true;
                });
              },
              onCameraIdle: () async {
                print("onCameraIdle#_lastMapPosition = $_cameraPosition");
                LocationProvider.of(context, listen: false)
                    .setLastIdleLocation(_cameraPosition.target);
                setState(() {
                  isCameraMoving = false;
                });
              },
              // onCameraMoveStarted: () {
              //   // setState(() {
              //   //   isCameraMoving = true;
              //   // });
              //   print(
              //       "onCameraMoveStarted#_lastMapPosition = $_cameraPosition");
              // },
              // onCameraMove: (CameraPosition cameraPosition) {
              //   setState(() {
              //     _cameraPosition = cameraPosition;
              //   });
              // },
              markers: {
                Marker(
                    draggable: true,
                    position: currentPosition.lastIdleLocation,
                    markerId: MarkerId('id'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta)),
              },
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: _cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            ),
            Align(
              alignment: AlignmentDirectional(0.05, 0.95),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.96,
                  height: 160,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
                            child: FloatingActionButton(
                              backgroundColor: Colors.blue,
                              onPressed: _goToMyCurrentLocation,
                              child: Icon(Icons.place, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: ListTile(
                          onTap: () {
                            Provider.of<AddressAPI>(context, listen: false)
                                .setGeoPoint(
                              GeoPoint(_cameraPosition.target.latitude,
                                  _cameraPosition.target.longitude),
                            );
                            Navigator.pop(context);
                          },
                          title: isCameraMoving
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : FutureBuilder<String>(
                                  future: getAddress(
                                      currentPosition.lastIdleLocation),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ));
                                    }
                                    String streetName = snapshot.data;
                                    print(streetName);
                                    return Text(
                                      streetName,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    );
                                  }),
                          // title: StreamBuilder<List<Placemark>>(
                          //     stream: placemarkFromCoordinates(
                          //       currentPosition.lastIdleLocation.latitude,
                          //       currentPosition.lastIdleLocation.longitude,
                          //     ).asStream(),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.hasError) {
                          //         return Text('Something went wrong');
                          //       }
                          //
                          //       if (snapshot.connectionState ==
                          //           ConnectionState.waiting) {
                          //         return Center(
                          //             child: CircularProgressIndicator(
                          //           color: Colors.white,
                          //         ));
                          //       }
                          //       String currentAddress =
                          //           snapshot.data.first.street;
                          //
                          //       return Text(
                          //         currentAddress,
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //         ),
                          //       );
                          //     }),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                          dense: false,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        );
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    setState(() {
      _cameraPosition = CameraPosition(
        bearing: 0.0,
        target: LatLng(position?.latitude, position?.longitude),
        tilt: 0.0,
        zoom: 17,
      );
    });
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      body: position != null && _cameraPosition != null
          ? buildMap()
          : Center(
              child: Container(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
    );
  }

  Future<String> getAddress(LatLng latLng) async {
    return await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    ).then((value) => value.first.street);
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}
