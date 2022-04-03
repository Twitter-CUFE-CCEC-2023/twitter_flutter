import 'package:flutter/cupertino.dart';

class UserModel {
  String? name;
  String? username;
  String? email;
  String? phone;
  String? profile_image_url;
  String? cover_image_url;
  String? bio;
  String? website;
  String? location;
  DateTime? created_at;
  bool? isVerified;
  String? role;
  int? followers_count;
  int? following_count;
  int? tweets_count;
  int? likes_count;
  late bool isBanned;
  DateTime? banDuration;
  bool? permanentBan;

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
