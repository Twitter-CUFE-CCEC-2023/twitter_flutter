import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  late String id = "";
  late String name = "";
  late String username = "";
  late String email = "";
  late String profile_image_url = "";
  late String cover_image_url = "";
  late String bio = "";
  late String website = "";
  late String location = "";
  late DateTime created_at = DateTime.now();
  late bool isVerified = false;
  //late String role;
  late int followers_count = 0;
  late int following_count = 0;
  late int tweets_count = 0;
  late int likes_count = 0;
  late bool isBanned = false;
  late DateTime birth_date = DateTime.now();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    profile_image_url = json["profile_image_url"];
    cover_image_url = json["cover_image_url"];
    bio = json["bio"];
    website = json["website"];
    location = json["location"];
    created_at = DateTime.parse(json["created_at"]);
    birth_date = DateTime.parse(json["birth_date"]);
    isVerified = json["isVerified"];
    //role = json["role"];
    followers_count = json["followers_count"];
    following_count = json["following_count"];
    tweets_count = json["tweets_count"];
    likes_count = json["likes_count"];
    isBanned = json["isBanned"];
  }

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        profile_image_url,
        cover_image_url,
        bio,
        website,
        location,
        created_at,
        isVerified,
        followers_count,
        following_count,
        tweets_count,
        likes_count,
        isBanned,
        birth_date
      ];
}
