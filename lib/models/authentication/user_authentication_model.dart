import 'package:twitter_flutter/models/objects/user.dart';

class UserAuthenticationModel {
  String? message;
  String? access_token;
  DateTime? token_expiration_date;
  UserModel? user;

  UserAuthenticationModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    access_token = json["access_token"];
    token_expiration_date = DateTime.parse(json["token_expiration_date"]);
    user = UserModel.fromJson(json["user"]);
  }
}
