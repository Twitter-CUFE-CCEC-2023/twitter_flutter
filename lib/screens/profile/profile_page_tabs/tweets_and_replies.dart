import 'package:flutter/material.dart';

class TweetsAndReplies extends StatefulWidget {
  const TweetsAndReplies({Key? key}) : super(key: key);

  @override
  State<TweetsAndReplies> createState() => _TweetsAndRepliesState();
}

class _TweetsAndRepliesState extends State<TweetsAndReplies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Tweets and Replies')),
    );
  }
}
