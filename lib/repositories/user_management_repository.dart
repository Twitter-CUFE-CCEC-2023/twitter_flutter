import 'dart:async';
import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/create_account/VerificationCode.dart';
import 'package:twitter_flutter/utils/Web%20Services/user_management_requests.dart';

class UserManagementRepository {
  late UserManagementRequests userManagementRequests;

  UserManagementRepository({required this.userManagementRequests});

  Future<UserAuthenticationModel> login({username, password}) async {
    try {
      String loginData =
          await userManagementRequests.login(username: username, password: password);
      return UserAuthenticationModel.fromJsonLogin(jsonDecode(loginData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserAuthenticationModel> signUp(
      {name, password, email, date_of_birth,gender,username}) async {
    try {
      String signupData = await userManagementRequests.signUp(
          name: name,
          password: password,
          email: email,
          birth_date: date_of_birth,
          gender: gender,
          username: username);
      return UserAuthenticationModel.fromJsonSignUp(jsonDecode(signupData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserAuthenticationModel> verify({id,verification_code}) async {
    try {
      String verificationData = await userManagementRequests.Verification(id:id,verification_code:verification_code);
      return UserAuthenticationModel.fromJsonSignUp(jsonDecode(verificationData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }


  Future<String> updatePassword(
      {required New_Password, required Old_Password}) async {
    try{
      String updatePasswordData = await userManagementRequests.UpdatePassword(New_Password: New_Password, Old_Password: Old_Password);
      return updatePasswordData;
    } on Exception catch(e)
    {
      throw Exception(e);
    }
  }

  Future<UserModel> editProfile() async {
    String data = await userManagementRequests.editProfile();
    return UserModel.fromJson(jsonDecode(data));
  }

}
