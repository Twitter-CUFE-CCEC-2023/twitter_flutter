import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/screens/profile/edit_profile.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/authentication_requests.dart';
import 'package:twitter_flutter/models/profile_management/Edit_profile_model.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/edit_profile_request.dart';
class ProfileRepository {
  late EditProfileRequests  profileReq;

  ProfileRepository({required this.profileReq});

  Future<UserProfileModel> editProfile({username,password}) async {
    try {
      String profileData = await profileReq.EditProfile();
      return UserProfileModel.fromJson(jsonDecode(profileData));
    } on Exception catch (e) {
      throw Exception(e);
    }


  }

}