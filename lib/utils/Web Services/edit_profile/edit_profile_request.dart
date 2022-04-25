import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class EditProfileRequests {
  late final String name;
  late final String location;
  late final String website;
  late final String bio;
  late final DateTime birth_date;
  late final String month_day_access;
  late final String year_access;
  late final String access_token;

  Future<String> EditProfile(
      { Name, Location, Website, Bio, Month_Day_Access, Year_Access, Birth_Date}) async {
    var headers = {'Content-Type': 'application/json'};
    // var headers = {'Content-Type': 'application/json','token':token};

    var body = jsonEncode(<String, String>{
      "name": Name ?? name,
      "location": Location ?? location,
      "website": Website ?? website,
      "bio": Bio ?? bio,
      "birth_date": Birth_Date ?? birth_date,
      "month_day_access": Month_Day_Access ?? month_day_access,
      "year_access": Year_Access ?? year_access,
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
      throw Exception("Invalid Profile Credentials");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }
}
