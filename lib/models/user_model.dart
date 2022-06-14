// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.profileImage,
    this.displayName,
  });

  String uid;
  String email;
  String profileImage;
  String? displayName;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        email: json["email"],
        profileImage: json["profileImage"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "profileImage": profileImage,
        "displayName": displayName,
      };
}
