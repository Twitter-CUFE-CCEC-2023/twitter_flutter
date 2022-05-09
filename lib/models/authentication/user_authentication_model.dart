import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/user.dart';

class UserAuthenticationModel extends Equatable{
  late String message;
  late String access_token;
  late DateTime token_expiration_date;
  late UserModel user;

  UserAuthenticationModel.fromJsonLogin(Map<String, dynamic> json) {
    message = json["message"];
    access_token = json["access_token"];
    token_expiration_date = DateTime.parse(json["token_expiration_date"]);
    user = UserModel.fromJson(json["user"]);

  }

  UserAuthenticationModel.fromJsonSignUp(Map<String, dynamic> json) {
    //TODO:To be uncommented upon deployment
    message = json["message"];
    user = UserModel.fromJson(json["user"]);
    access_token = "";
    token_expiration_date = DateTime(0);
  }

  @override
  List<Object?> get props => [message,access_token,token_expiration_date,user];
}
