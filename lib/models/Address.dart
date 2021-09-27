// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.AddressID,
    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
    this.location,
  });

  String AddressID;
  String streetAddress;
  String city;
  String state;
  String postalCode;
  GeoPoint location;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        AddressID: json["AddressID"],
        streetAddress: json["streetAddress"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postalCode"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "AddressID": AddressID,
        "streetAddress": streetAddress,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "location": GeoPoint(location.latitude, location.longitude),
      };
}
