import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class UserManagementRequests {
  Future<String> login({username, password}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String,dynamic>{
      "email_or_username": username,
      "password": password,
      "remember_me" : true
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

    print(res.body);

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

  Future<String> UpdatePassword(
      {required New_Password, required Old_Password}) async {
    var pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + accessToken!
    };

    var body = jsonEncode(<String, String>{
      "old_password": Old_Password,
      "new_password": New_Password
    });

    http.Response res = await http.put(
        Uri.parse("$ENDPOINT/auth/update-password"),
        body: body,
        headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> editProfile(){
    //TODO Complete edit profile Request
    return Future.delayed(Duration.zero).then((_) => "null");
    //return data.user
  }

}
