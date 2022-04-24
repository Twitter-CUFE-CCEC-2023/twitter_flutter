import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends Equatable{
  late String name;
  late String username;
  late String email;
  late DateTime birth_date;
  late String gender;
  late String location;
  late String bio;
  late List<UserModel> followers;
  late List<UserModel> followings;
  late String website;
  late int verificationCode ;
  late DateTime verificationCodeExpiration;
  late int resetPasswordCode;
  late DateTime resetPasswordCodeExpiration;
  late bool isVerified;
  late String profile_picture;
  late String cover_picture;
  late bool isBanned;
  late String monthDayBirthAccessId;
  late String yearBirthAccessId;
  late int _id;
  late DateTime createdAt;
  late DateTime updatedAt;

  //__v,tokens[]

  UserModel.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    username = json["username"];
    email = json["email"];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name,username,email,];
}
