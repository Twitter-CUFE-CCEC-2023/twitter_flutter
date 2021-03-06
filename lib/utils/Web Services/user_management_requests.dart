import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/screens/authentication/forget_password1.dart';
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class UserManagementRequests {
  Future<String> login({username, password}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String, dynamic>{
      "email_or_username": username,
      "password": password,
      "remember_me": true
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

  Future<String> Verification(
      {required email_or_username, required verificationCode}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String, dynamic>{
      "email_or_username": email_or_username,
      "verificationCode": verificationCode
    });

    http.Response res = await http.put(
        Uri.parse("$ENDPOINT/auth/verify-credentials"),
        body: body,
        headers: headers);

    int statusCode = res.statusCode;
    print(res.body);
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

  Future<String> editProfile(
      {Name,
      Location,
      Website,
      Bio,
      Month_Day_Access,
      Year_Access,
      Birth_Date}) async {
    var headers = {'Content-Type': 'application/json'};

    var pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");
    var body = jsonEncode(<String, String>{
      "access_token": accessToken!,
      "name": Name,
      "location": Location,
      "website": Website,
      "bio": Bio,
      "birth_date": Birth_Date,
      "month_day_access": Month_Day_Access,
      "year_access": Year_Access,
    });

    http.Response res = await http.put(
        Uri.parse("$ENDPOINT/user/update-profile"),
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

  //return data.user

  Future<String> getUserProfile(
      {required String access_token, required String username}) async {
    var pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + access_token
    };

    http.Response res =
        await http.get(Uri.parse("$ENDPOINT/info/$username"), headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Unauthenticated");
    } else if (statusCode == 404) {
      throw Exception("User not found");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> getFollowingRequest(
      {required String access_token,
      required String username,
      required int page,
      required int count}) async {
    var pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + access_token,
    };
    log(access_token+ username.toString() + page.toString() +  count.toString());
    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/following/list/:$username/:$page/:$count"),
        headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("User is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid user Id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> followUser(
      {access_token	, username, notify}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String, String>{
      "access_token": access_token,
      "username": username,
      "notify": notify,
    });

    http.Response res = await http.post(Uri.parse("$ENDPOINT/user/follow"),
        body: body, headers: headers);

    int statusCode = res.statusCode;
    print(res.body);
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("BadRequest");
    } else if (statusCode == 401) {
      throw Exception("User is not authenticated");
    } else if (statusCode == 500) {
      throw Exception("Invalid user Id");
    } else {
      throw Exception("The server encountered an unexpected condition which prevented it from fulfilling the request");
    }
  }

   Future<String> getFollowersRequest(
      {required String access_token,
      required String username,
      required int page,
      required int count}) async {
    var pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + access_token,
    };
    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/follower/list/:$username/:$page/:$count"),
        headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("User is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid user Id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }


  Future<String> forgetPassword({username, password,resetPasswordCode}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String, dynamic>{
      "email_or_username": username,
      "password": password,
      "resetPasswordCode":resetPasswordCode
    });

    http.Response res = await http.put(
        Uri.parse("$ENDPOINT/auth/reset-password"),
        body: body,
        headers: headers);

    int statusCode = res.statusCode;
    print(res.body);
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

  Future<String> forgetPasswordEmail(
      {username}) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode(<String, String>{
      "email_or_username": username,
    });

    http.Response res = await http.post(Uri.parse("$ENDPOINT/auth/send-reset-password"),
        body: body, headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid or expired verification code");
    } else if (statusCode == 404) {
      throw Exception("NotFound");
    } else if (statusCode == 500) {
      throw Exception("InternalServerError");
    } else {
      throw Exception("Undefined Error");
    }
  }



}





