import 'dart:convert';
import 'package:twitter_flutter/models/objects/user.dart';

class UserProfileModel {
  late String message;
  late UserModel user;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    //TODO:To be uncommented upon deployment
    /*message = json["message"];)*/;

    //TODO:Josn Server Response format to be deleted upon deployment
    message=" ";
    user = UserModel.fromJson(json["user"]);
  }
}