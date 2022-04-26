import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/user.dart';

class UserPasswordModel extends Equatable {
  late String message;
  late UserModel user;

  UserPasswordModel.fromJsonUpdatePassword(Map<String, dynamic> json) {
    message = json["message"];
    user = UserModel.fromJson(json["user"]);

    /*//TODO:Josn Server Response format to be deleted upon deployment
    message=" ";*/

  }

  @override
  // TODO: implement props
  List<Object?> get props => [message, user];
}