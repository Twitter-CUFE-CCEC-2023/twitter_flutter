import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:twitter_flutter/utils/Web Services/constants.dart';

class TweetsManagementRequests {
  Future<String> getLoggedUserTweets(
      {required String access_token,
      required String username,
      int count = 20,
      int page = 1,
      bool replies = false}) async {
    var headers = {'Authorization': 'Bearer $access_token'};

    http.Response res = await http.get(
        Uri.parse(
            "$ENDPOINT/status/tweets/list/$username/$page/$count?include_replies=$replies"),
        headers: headers);
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

  Future<String> getLoggedUserLikedTweets(
      {required String access_token,
      required String username,
      page = 1,
      int? count = 20}) async {
    var headers = {'Authorization': 'Bearer $access_token'};

    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/liked/list/$username/$page/$count"),
        headers: headers);
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      print(res.body);
      return res.body;
    } else if (statusCode == 400) {
      throw Exception("Client Error, Can not process your request");
    } else if (statusCode == 401) {
      throw Exception("Invalid Verification Code Credentials");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("${res.statusCode} ${res.body} Undefined Error from lt");
    }
  }

  Future<String> getLoggedUserMediaTweets(
      {required String access_token,
      required String username,
      page = 1,
      int? count = 20}) async {
    var headers = {'Authorization': 'Bearer $access_token'};

    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/media/list/$username/$page/$count"),
        headers: headers);
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
      throw Exception("${res.statusCode}  Undefined Error from lt");
    }
  }

  Future<String> fetchTweets(
      {required String access_token,
      required int count,
      required int page}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res = await http.get(Uri.parse("$ENDPOINT/home/$page/$count"),
        headers: headers);

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

    //print(res.body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      print(res.body);
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
      throw Exception(
          "${res.statusCode} ${res.body} Undefined Error from like a tweet");
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
      required List<File> media}) async {
    var headers = {'Authorization': 'Bearer $access_token'};

    var request =
        http.MultipartRequest('POST', Uri.parse("$ENDPOINT/status/tweet/post"));

    request.headers.addAll(headers);

    request.fields.addAll({"content": content});

    for (File file in media) {
      request.files.add(await http.MultipartFile.fromPath('media', file.path));
    }

    http.StreamedResponse res = await request.send();

    int statusCode = res.statusCode;

    if (statusCode == 200) {
      return await res.stream.bytesToString();
      //return await res.stream.bytesToString();
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

  Future<String> postReplay(
      {required String access_token,
      required String content,
      required String Replay_id,
      required List<File> media}) async {
    var headers = {'Authorization': 'Bearer $access_token'};

    var request =
        http.MultipartRequest('POST', Uri.parse("$ENDPOINT/status/tweet/post"));

    request.headers.addAll(headers);

    request.fields.addAll({"content": content, "replied_to_tweet": Replay_id});

    for (File file in media) {
      request.files.add(await http.MultipartFile.fromPath('media', file.path));
    }

    http.StreamedResponse res = await request.send();

    int statusCode = res.statusCode;

    if (statusCode == 200) {
      return await res.stream.bytesToString();
      //return await res.stream.bytesToString();
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

  Future<String> deleteTweet(
      {required String access_token, required String tweet_id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode(<String, String>{
      "id": tweet_id,
    });

    http.Response res = await http.delete(
        Uri.parse("$ENDPOINT/status/tweet/delete"),
        headers: headers,
        body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      //print(res.body);
      return res.body;
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

  Future<String> getTweetReplay(
      {required String access_token,
      required int count,
      required int page}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res = await http.get(Uri.parse("$ENDPOINT/home/$page/$count"),
        headers: headers);

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

  Future<String> getTweetByID(
      {required String access_token, required String id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    http.Response res = await http.get(
        Uri.parse("$ENDPOINT/status/tweet/$id?include_replies=true"),
        headers: headers);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 404) {
      throw Exception("Invalid tweet id");
    } else if (statusCode == 401) {
      throw Exception("user is not authenticated");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error");
    }
  }

  Future<String> RetweetTweet(
      {required String access_token, required String tweet_id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode(<String, String>{
      "id": tweet_id,
    });

    http.Response res = await http.post(Uri.parse("$ENDPOINT/status/retweet"),
        headers: headers, body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("User is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid tweet id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error from Retwet a tweet");
    }
  }

  Future<String> UnRetweetTweet(
      {required String access_token, required String tweet_id}) async {
    var headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode(<String, String>{
      "id": tweet_id,
    });

    http.Response res = await http.delete(
        Uri.parse("$ENDPOINT/status/tweet/delete"),
        headers: headers,
        body: body);

    int statusCode = res.statusCode;
    if (statusCode == 200) {
      return res.body;
    } else if (statusCode == 401) {
      throw Exception("User is not authenticated");
    } else if (statusCode == 404) {
      throw Exception("Invalid tweet id");
    } else if (statusCode == 500) {
      throw Exception("Server Error");
    } else {
      throw Exception("Undefined Error from Retwet a tweet");
    }
  }
}
