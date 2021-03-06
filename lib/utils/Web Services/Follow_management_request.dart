import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class UserFollowerRequests {
  Future<String> GetFollowers(
      {required String access_token,
      required String username,
      required int count,
      required int page}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/follower/list/$username/$page/$count"),
        headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("IUser is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid user Id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> followingAPIReq(
      {required String access_token,
      required String username,
      required int count,
      required int page}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/following/list/$username/$page/$count"),
        headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("IUser is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid user Id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> followUser(
      {required String access_token, required String id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res =
        await http.post(Uri.parse("$ENDPOINT/user/follow"), headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      log(res.body);
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("IUser is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid user Id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> UnfollowUser(
      {required String access_token, required String id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode(<String, String>{
      "id": id,
    });

    http.Response res = await http.delete(Uri.parse("$ENDPOINT/user/unfollow"),
        headers: headers, body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      log(res.body);
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("Invalid Verification Code Credentials");
    } else if (statusCode == 404) {
      throw Exception("Invalid user id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }
}
