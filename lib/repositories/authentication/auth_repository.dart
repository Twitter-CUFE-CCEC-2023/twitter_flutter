import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/user_login_request.dart';

class AuthRepository {
  String username;
  String password;
  late UserLoginRequest loginReq;

  AuthRepository(this.username,this.password)
  {
    loginReq = UserLoginRequest(username,password);
  }

  Future<UserAuthenticationModel> login() async {
    try {
      String loginData = await loginReq.Login();
      return UserAuthenticationModel.fromJson(jsonDecode(loginData));
    } on Exception catch (e) {
      throw Exception(e);
    }

  }
}
