import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class UpdatePasswordRequests {
  Future<String> UpadtePassword(
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
      throw Exception("Invalid Password Credentials");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }
}
