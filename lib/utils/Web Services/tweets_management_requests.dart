import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class TweetsManagementRequests {
  Future<String> getLoggedUserTweets(
      {required String access_token,
      required String username,
      bool replies = false}) async {
    var headers = {'Authorization': 'Bearer $access_token'};

    http.Response res = await http.get(
        Uri.parse(
            "$ENDPOINT/status/tweets/list/$username?include_replies=$replies"),
        headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
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

  Future<String> fetchTweets(
      {required String access_token, required int count}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res = await http.get(Uri.parse("$ENDPOINT/home?count=$count"),
        headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
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

  Future<String> likeTweet(
      {required String access_token, required String tweet_id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode(<String, String>{
      "id": tweet_id,
    });

    http.Response res = await http.post(Uri.parse("$ENDPOINT/status/like"),
        headers: headers, body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid Verification Code Credentials");
    } else if (statusCode == 404) {
      throw Exception("Invalid tweet id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> unlikeTweet(
      {required String access_token, required String tweet_id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode(<String, String>{
      "id": tweet_id,
    });

    http.Response res = await http.delete(Uri.parse("$ENDPOINT/status/unlike"),
        headers: headers, body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid Verification Code Credentials");
    } else if (statusCode == 404) {
      throw Exception("Invalid tweet id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> postTweet(
      {required String access_token,
      required String content,
      List<int>? mediaIds}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode(<String, dynamic>{
      "content": content,
    });

    //      "media_ids": mediaIds ?? []

    http.Response res = await http.post(
        Uri.parse("$ENDPOINT/status/tweet/post"),
        headers: headers,
        body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
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
