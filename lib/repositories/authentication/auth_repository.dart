import 'dart:convert';

import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';
import 'package:twitter_flutter/utils/Web%20Services/authentication/authentication_requests.dart';

class AuthRepository {
  late AuthenticationRequests loginReq;

  AuthRepository({required this.loginReq});

  Future<UserAuthenticationModel> login({username,password}) async {
    try {
      String loginData = await loginReq.Login(username:username,password:password);
      return UserAuthenticationModel.fromJson(jsonDecode(loginData));
    } on Exception catch (e) {
      throw Exception(e);
    }


  }

}
