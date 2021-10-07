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
    this.Area,
    this.StreetName,
    this.BuildingName,
    this.floorNumber,
    this.buildingType,
    this.location,
    this.addressName,
    this.apartmentNumber,
    this.phoneNumber,
    this.Landline,
    this.Landmark,
  });

  String AddressID;
  String Area;
  String StreetName;
  String BuildingName;
  String floorNumber;
  String apartmentNumber;
  String addressName;
  String Landmark;
  String phoneNumber;
  String Landline;
  GeoPoint location;
  String buildingType;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      AddressID: json["AddressID"],
      Area: json["Area"],
      StreetName: json["StreetName"],
      BuildingName: json["BuildingName"],
      floorNumber: json["floorNumber"],
      apartmentNumber: json["apartmentNumber"],
      addressName: json["addressName"],
      Landmark: json["Landmark"],
      Landline: json["Landline"],
      location: json["location"],
      phoneNumber: json["phoneNumber"],
      buildingType: json["buildingType"]
      // buildingType: BuildingType.values.firstWhere(
      //     (element) => element.toString() == json["buildingType"]),
      );

  Map<String, dynamic> toJson() => {
        "AddressID": AddressID,
        "Area": Area,
        "StreetName": StreetName,
        "BuildingName": BuildingName,
        "floorNumber": floorNumber,
        "addressName": addressName,
        "apartmentNumber": apartmentNumber,
        "Landline": Landline,
        "Landmark": Landmark,
        "phoneNumber": phoneNumber,
        "location": GeoPoint(location.latitude, location.longitude),
        "buildingType": buildingType,
      };
}


