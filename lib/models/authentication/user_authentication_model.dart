import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/user.dart';

class UserAuthenticationModel extends Equatable{
  late String message;
  late String access_token;
  late DateTime token_expiration_date;
  late UserModel user;

  UserAuthenticationModel.fromJson(Map<String, dynamic> json) {
    //TODO:To be uncommented upon deployment
    message = json["message"];
    access_token = json["access_token"];
    token_expiration_date = DateTime.parse(json["token_expiration_date"]);
    user = UserModel.fromJson(json["user"]);
    // //TODO:Josn Server Response format to be deleted upon deployment
    // message=" ";
    // access_token = json["accessToken"];
    // token_expiration_date = DateTime(0);


  }

  @override
  // TODO: implement props
  List<Object?> get props => [message,access_token,token_expiration_date,user];
}
