import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/screens/create_account/VerificationCode.dart';
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class AuthenticationRequests {
  Future<String> Login({username, password}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String,dynamic>{
      "email_or_username": username,
      "password": password,
      "remember_me" : true
    });

    //TODO:Josn-Server-auth request body format to be deleted upon deployment
    // var body = jsonEncode(<String, String>{
    //   "email": username ?? _email_or_username,
    //   "password": password ?? _password
    // });

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
      {name, email, username, gender, password, birth_date}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String, String>{
      "email": email,
      "username": username,
      "password": password,
      "name": name,
      "gender": gender,
      "birth_date": birth_date,
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

  Future<String> Verification({id,verification_code}) async {
    var headers = {'Content-Type': 'application/json'};

    //TODO:Correct post request body to be used upon deployment
    /*var body = jsonEncode(<String,dynamic>{
      "email_or_username": _email_or_username,
      "password": _password,
      "remember_me" : _remember_me
    });*/

    //TODO:Josn-Server-auth request body format to be deleted upon deployment
    var body = jsonEncode(<String, String?>{
      "id": id ,
      "verification_code": verification_code
    });

    http.Response res = await http.put(Uri.parse("$ENDPOINT/auth/login"),
        body: body, headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid Verification Code Credentials");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }


}
