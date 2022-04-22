import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class AuthenticationRequests {
  late final String _email_or_username;
  late final String _password;
  late final String _accessToken;
  late final bool _remember_me = true;

  Future<String> Login({username, password}) async {
    var headers = {'Content-Type': 'application/json'};

    //TODO:Correct post request body to be used upon deployment
    /*var body = jsonEncode(<String,dynamic>{
      "email_or_username": _email_or_username,
      "password": _password,
      "remember_me" : _remember_me
    });*/

    //TODO:Josn-Server-auth request body format to be deleted upon deployment
    var body = jsonEncode(<String, String>{
      "email": username ?? _email_or_username,
      "password": password ?? _password
    });

    http.Response res = await http.post(Uri.parse("$ENDPOINT/auth/login"),
        body: body, headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid Login Credentials");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> signUp(
      {name, email, phone_number, password, date_of_birth}) async {
    var headers = {'Content-Type': 'application/json'};
    //TODO:Correct post request body to be used upon deployment
    /*var body = jsonEncode(<String,dynamic>{
      "email_or_username": _email_or_username,
      "password": _password,
      "remember_me" : _remember_me
    });*/

    //TODO:Josn-Server-auth request body format to be deleted upon deployment
    var body = jsonEncode(<String, String>{
      "email": email ?? "",
      "username": '',
      "password": password,
      "name": name,
      "gender": '',
      "birth_date": date_of_birth,
      "phone_number": phone_number ?? "",
    });
    http.Response res = await http.post(Uri.parse("$ENDPOINT/auth/signup"),
        body: body, headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 409) {
      throw Exception("Conflict");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }
}