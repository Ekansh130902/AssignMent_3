import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String usernameOrPhoneNumber;
  final String dob;
  final String fcm_token;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.usernameOrPhoneNumber,
    required this.dob,
    required this.fcm_token
  });

  // to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      usernameOrPhoneNumber: map['usernameOrPhoneNumber'],
      dob: map['dob'],
      fcm_token: map['fcm_token']
    );
  }

  // Method to convert UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'usernameOrPhoneNumber': usernameOrPhoneNumber,
      'dob': dob,
      'fcm_token':fcm_token
    };
  }
}
