import 'package:flutter/cupertino.dart';

class UserModel {
  late String name;
  late String username;
  late String email;
  late String phone;
  late String profile_image_url;
  late String cover_image_url;
  late String bio;
  late String website;
  late String location;
  late DateTime created_at;
  late bool isVerified;
  late String role;
  late int followers_count;
  late int following_count;
  late int tweets_count;
  late int likes_count;
  late bool isBanned;
  late DateTime banDuration;
  late bool permanentBan;

  /*UserModel({
    this.name,
    this.username,
    this.email,
    this.phone,
    this.profile_image_url,
    this.cover_image_url,
    this.bio,
    this.website,
    this.location,
    this.created_at,
    this.isVerified,
    this.role,
    this.followers_count,
    this.following_count,
    this.tweets_count,
    this.likes_count,
    this.isBanned,
    this.banDuration,
    this.permanentBan,
  });*/

  UserModel.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    profile_image_url = json["profile_image_url"];
    cover_image_url = json["cover_image_url"];
    bio = json["bio"];
    website = json["website"];
    location = json["location"];
    created_at = DateTime.parse(json["created_at"]);
    isVerified = json["isVerified"];
    role = json["role"];
    followers_count = json["followers_count"];
    following_count = json["following_count"];
    tweets_count = json["tweets_count"];
    likes_count= json["likes_count"];
    isBanned= json["isBanned"];
    banDuration= isBanned? DateTime.parse(json["banDuration"]) : DateTime(0);
    permanentBan= json["permanentBan"];
  }
}
