// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:googleapis/people/v1.dart';
//
// class Utils {
//   static DateTime toDateTime(Timestamp value) {
//     if (value == null) return null;
//
//     return value.toDate();
//   }
//
//   static dynamic fromDateTimeToJson(DateTime date) {
//     if (date == null) return null;
//
//     return date.toUtc();
//   }
//
//   static Map<String, dynamic> birthdayToDateTime(Date value) {
//     // if (value == null) return null;
//
//     return value?.toJson();
//   }
//
//   static dynamic birthdayFromDateTimeToJson(Date date) {
//     if (date == null) return null;
//
//     return DateTime(date.year, date.month, date.day).toUtc();
//   }
// }
