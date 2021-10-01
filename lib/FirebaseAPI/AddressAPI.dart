import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thrifters_united/models/Address.dart';

class AddressAPI extends ChangeNotifier {
  GeoPoint geoPoint;

  void setGeoPoint(GeoPoint currentGeoPoint) {
    geoPoint = currentGeoPoint;
    notifyListeners();
  }

  static Future addAddresses(Address address, String userID) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/addresses')
        .withConverter<Address>(
          fromFirestore: (snapshot, _) => Address.fromJson(snapshot.data()),
          toFirestore: (address, _) => address.toJson(),
        );
    await UsersRef.add(address);
  }

  static Future<String> addLocationToAddresses(
      GeoPoint geoPoint, String userID) async {
    final UsersRef = FirebaseFirestore.instance
        .collection('users/$userID/addresses')
        .withConverter<Address>(
          fromFirestore: (snapshot, _) => Address.fromJson(snapshot.data()),
          toFirestore: (address, _) => address.toJson(),
        );
    Address address = Address(
      location: GeoPoint(geoPoint.latitude, geoPoint.longitude),
    );
    return await UsersRef.add(
      address,
    ).then((value) => value.id);
  }
}
