import 'package:equatable/equatable.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'mediaModel.dart';

class TweetModel extends Equatable {
  late String id;
  late String content;
  late int likes_count;
  late int retweets_count;
  late int quotes_count;
  late int replies_count;
  late DateTime created_at;
  late bool is_liked;
  late bool is_retweeted;
  late bool is_quoted;
  late String? quote_comment;
  late bool is_reply;
  late List<UserModel> mentions;
  late List<MediaModel> media;

  TweetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    likes_count = json['likes_count'];
    retweets_count = json['retweets_count'];
    quotes_count = json['quotes_count'];
    replies_count = json['replies_count'];
    created_at = DateTime.parse(json['created_at']);
    is_liked = json['is_liked'];
    is_retweeted = json['is_retweeted'];
    is_quoted = json['is_quoted'];
    quote_comment = json['quote_comment'];
    is_reply = json['is_reply'];
    mentions =
        (json['mentions'] as List).map((i) => UserModel.fromJson(i)).toList();
    media = (json['media'] as List).map((i) => MediaModel.fromJson(i)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        content,
        likes_count,
        retweets_count,
        quotes_count,
        replies_count,
        created_at,
        is_liked,
        is_retweeted,
        is_quoted,
        quote_comment,
        is_reply,
        is_retweeted,
        mentions,
        media,
      ];
}

class ReplyTweetModel extends TweetModel {
  late UserModel user;

  ReplyTweetModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    user = json['user'];
  }

  @override
  List<Object?> get props => [
        super.props,
        user,
      ];
}

class TweetWithRepliesModel{
  late TweetModel tweet;
  late List<ReplyTweetModel> replies;

  TweetWithRepliesModel.fromJson(Map<String, dynamic> json)
  {
    tweet = TweetModel.fromJson(json);
    replies = (json['replies'] as List).map((i) => ReplyTweetModel.fromJson(i)).toList();
  }

}
