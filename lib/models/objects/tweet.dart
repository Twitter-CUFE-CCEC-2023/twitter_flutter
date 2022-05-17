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
  late List<String> media;

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
    media = (json['media'] as List).cast<String>();
  }

  TweetModel.copy(TweetModel other) {
    id = other.id;
    content = other.content;
    likes_count = other.likes_count;
    retweets_count = other.retweets_count;
    quotes_count = other.quotes_count;
    replies_count = other.replies_count;
    created_at = other.created_at;
    is_liked = other.is_liked;
    is_retweeted = other.is_retweeted;
    is_quoted = other.is_quoted;
    quote_comment = other.quote_comment;
    is_reply = other.is_reply;
    mentions = other.mentions;
    media = other.media;
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
    user = UserModel.fromJson(json['user']);
  }

  ReplyTweetModel.copy(TweetModel tweet, UserModel user) : super.copy(tweet) {
    this.user = UserModel.copy(user);
  }

  @override
  List<Object?> get props => [
        super.props,
        user,
      ];
}

class TweetWithRepliesModel {
  late TweetModel tweet;
  late List<ReplyTweetModel> replies;

  TweetWithRepliesModel.fromJson(Map<String, dynamic> json) {
    tweet = TweetModel.fromJson(json);
    replies = (json['replies'] as List)
        .map((i) => ReplyTweetModel.fromJson(i))
        .toList();
  }
}

class HomeTweetWithReplies {
  late ReplyTweetModel tweet;
  late List<ReplyTweetModel> replies;
  HomeTweetWithReplies.fromJson(Map<String, dynamic> json) {
    tweet = ReplyTweetModel.fromJson(json);
    replies = (json['replies'] as List)
        .map((i) => ReplyTweetModel.fromJson(i))
        .toList();
  }
}
