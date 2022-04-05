import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';
import 'package:twitter_flutter/models/authentication/user_authentication_model.dart';

class UserLoginRequest {
  late final String _email_or_username;
  late final String _password;
  late final bool _remember_me = true;

  UserLoginRequest(this._email_or_username, this._password);

  Future<String> Login() async {
    var headers = {'Content-Type': 'application/json'};

    //TODO:Correct post request body to be used upon deployment
    /*var body = jsonEncode(<String,dynamic>{
      "email_or_username": _email_or_username,
      "password": _password,
      "remember_me" : _remember_me
    });*/

    //TODO:Josn-Server-auth request body format to be deleted upon deployment
    var body = jsonEncode(<String,String>{
      "email": _email_or_username,
      "password": _password
    });

    http.Response res = await http.post(Uri.parse("$ENDPOINT/auth/login"),
        body: body, headers: headers);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      String? errorMessage = "Login Error: " + res.reasonPhrase !+ "-StatusCode:" +res.statusCode.toString() ;
      throw Exception(errorMessage);
    }
  }
}
