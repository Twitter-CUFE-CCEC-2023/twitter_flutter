import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/authentication_requests.dart';
import 'package:twitter_flutter/models/profile_management/Edit_profile_model.dart';
import 'package:twitter_flutter/utils/Web Services/edit_profile/edit_profile_request.dart';
class ProfileRepository {
  late EditProfileRequests ProfileReq;

  ProfileRepository({required this.ProfileReq});

  Future<UserProfileModel> login({username,password}) async {
    try {
      String ProfileData = await ProfileReq.EditProfile();
      return UserProfileModel.fromJson(jsonDecode(ProfileData));
    } on Exception catch (e) {
      throw Exception(e);
    }


  }

}