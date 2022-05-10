import 'dart:async';
import 'dart:convert';
import 'package:twitter_flutter/models/objects/tweet.dart';
import 'package:twitter_flutter/utils/Web Services/tweets_management_requests.dart';

class TweetsManagementRepository {
  late TweetsManagementRequests tweetsManagementRequests;
  TweetsManagementRepository({required this.tweetsManagementRequests});

  Future<List<TweetModel>> fetchTweets(
      {required String access_token, required int count}) async {
    try {
      String tweets = await tweetsManagementRequests.fetchTweets(
          access_token: access_token, count: count);
      return (jsonDecode(tweets)["tweets"] as List)
          .map((i) => TweetModel.fromJson(i))
          .toList();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TweetModel>> getLoggedUserTweets(
      {required String access_token,
      required String username,
      bool replies = false}) async {
    try {
      String tweetData = await tweetsManagementRequests.getLoggedUserTweets(
          access_token: access_token, username: username, replies: replies);
      //print(tweetData);
      return (jsonDecode(tweetData)["tweets"] as List)
          .map((i) => TweetModel.fromJson(i))
          .toList();
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<ReplyTweetModel> likeTweet(
      {required String access_token, required String tweet_id}) async {
    try {
      String tweetData = await tweetsManagementRequests.likeTweet(
          access_token: access_token, tweet_id: tweet_id);
      //print(tweetData);
      return ReplyTweetModel.fromJson(jsonDecode(tweetData)['tweet']);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<TweetModel> postTweet(
      {required String access_token,
      required String content,
      List<int>? mediaIds}) async {
    try {
      String tweetData = await tweetsManagementRequests.postTweet(
          access_token: access_token, content: content, mediaIds: mediaIds);
      //print(tweetData);
      return TweetModel.fromJson(jsonDecode(tweetData)['tweet']);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<ReplyTweetModel> unlikeTweet(
      {required String access_token, required String tweet_id}) async {
    try {
      String tweetData = await tweetsManagementRequests.unlikeTweet(
          access_token: access_token, tweet_id: tweet_id);
      //print(tweetData);
      return ReplyTweetModel.fromJson(jsonDecode(tweetData)['tweet']);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
