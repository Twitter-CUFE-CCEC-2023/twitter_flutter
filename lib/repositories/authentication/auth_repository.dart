import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/screens/create_account/VerificationCode.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/authentication_requests.dart';

class AuthRepository {
  late AuthenticationRequests authReq;

  AuthRepository({required this.authReq});

  Future<UserAuthenticationModel> login({username, password}) async {
    try {
      String loginData =
          await authReq.Login(username: username, password: password);
      return UserAuthenticationModel.fromJsonLogin(jsonDecode(loginData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserAuthenticationModel> signUp(
      {name, password, email, date_of_birth,gender,username}) async {
    try {
      String signupData = await authReq.signUp(
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
  Future<UserAuthenticationModel> verification({id,verification_code}) async {
    try {
      String verificationData = await authReq.Verification(id:id,verification_code:verification_code);
      return UserAuthenticationModel.fromJsonSignUp(jsonDecode(verificationData));
    } on Exception catch (e) {
      throw Exception(e);
    }


  }

}
