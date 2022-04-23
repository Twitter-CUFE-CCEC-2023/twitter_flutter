import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/authentication_requests.dart';

class AuthRepository {
  late AuthenticationRequests loginReq;

  AuthRepository({required this.loginReq});

  Future<UserAuthenticationModel> login({username, password}) async {
    try {
      String loginData =
          await loginReq.Login(username: username, password: password);
      return UserAuthenticationModel.fromJson(jsonDecode(loginData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<UserAuthenticationModel> signUp(
      {name, password, email, phone_number, date_of_birth,gender,username}) async {
    try {
      String signupData = await loginReq.signUp(
          name: name,
          password: password,
          email: email,
          date_of_birth: date_of_birth,
          gender: gender,
          username: username);
      return UserAuthenticationModel.fromJson(jsonDecode(signupData));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
