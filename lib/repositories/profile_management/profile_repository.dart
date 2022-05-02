import 'dart:convert';
import 'package:twitter_flutter/models/profile_management/Edit_profile_model.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/edit_profile_request.dart';
class ProfileRepository {
  late EditProfileRequests  profileReq;

  ProfileRepository({required this.profileReq});


    Future<UserProfileModel> editProfile(
      {name, location, website, bio,birth_date,month_day_access,year_access	}) async {
    try {
      String profileData = await profileReq.EditProfile(
          Name: name,
          Location: location,
          Website: website,
          Bio: bio,
          Birth_Date: birth_date,
          Month_Day_Access: month_day_access,
          Year_Access: year_access);
      return UserProfileModel.fromJson(jsonDecode(profileData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

}