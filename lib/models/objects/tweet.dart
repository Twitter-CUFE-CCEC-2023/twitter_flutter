import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'mediaModel.dart';

class Tweet extends Equatable {
  late int id;
  late String content;
  late int user_id; //not present
  late int likes_count;
  late int retweets_count;
  late int quotes_tweets_count; //quotes_count
  late int replies_count;
  late DateTime created_at;
  late bool isLiked;
  late bool isRetweeted;
  late bool isQuoted;
  late String quote_comment;
  late List<int> parent_tweet_id;
  late bool isReply;
  late bool isQuotdTweet;
  late bool isRetweetTweet;
  late List<UserModel> mentions;
  late List<String> hashtags;
  late List<String> urls;
  late List<MediaModel> media;

  Tweet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user_id = json['user_id'];
    likes_count = json['likes_count'];
    retweets_count = json['retweets_count'];
    quotes_tweets_count = json['quotes_tweets_count'];
    replies_count = json['replies_count'];
    created_at = DateTime.parse(json['created_at']);
    isLiked = json['isLiked'];
    isRetweeted = json['isRetweeted'];
    isQuoted = json['isQuoted'];
    quote_comment = json['quote_comment'];
    parent_tweet_id = json['parent_tweet_id'];
    isReply = json['isReply'];
    isQuotdTweet = json['isQuotdTweet'];
    isRetweetTweet = json['isRetweetTweet'];
    mentions =
        (json['mentions'] as List).map((i) => UserModel.fromJson(i)).toList();
    hashtags = json['hashtags'];
    urls = json['urls'];
    media = (json['media'] as List).map((i) => MediaModel.fromJson(i)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        content,
        user_id,
        likes_count,
        retweets_count,
        quotes_tweets_count,
        replies_count,
        created_at,
        isLiked,
        isRetweeted,
        isQuoted,
        quote_comment,
        parent_tweet_id,
        isReply,
        isQuotdTweet,
        isRetweetTweet,
        mentions,
        hashtags,
        urls,
        media,
      ];
}
