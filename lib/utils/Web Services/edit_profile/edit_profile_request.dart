import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class EditProfileRequests {
  Future<String> EditProfile(
      { Name, Location, Website, Bio, Month_Day_Access, Year_Access, Birth_Date}) async {
    var headers = {'Content-Type': 'application/json'};

    var pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");
    var body = jsonEncode(<String, String>{
      "access_token" : accessToken!,
      "name": Name ,
      "location": Location ,
      "website": Website ,
      "bio": Bio ,
      "birth_date": Birth_Date ,
      "month_day_access": Month_Day_Access ,
      "year_access": Year_Access ,
    });

    http.Response res = await http.put(
        Uri.parse("$ENDPOINT//user/update-profile"),
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
}
