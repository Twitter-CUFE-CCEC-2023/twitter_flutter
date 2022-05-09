import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class TweetsManagementRequests {

  Future<String> getLoggedUserTweets (
      {required String access_token, required String username,bool replies = false}) async {
    var headers = {
      'Authorization': 'Bearer $access_token'
    };

    http.Response res = await http.get(Uri.parse("$ENDPOINT/status/tweets/list/$username?include_replies=$replies"),headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
    }else if (statusCode == 400) {
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
