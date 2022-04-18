import 'package:flutter/material.dart';

class Tweets extends StatefulWidget {
  const Tweets({Key? key}) : super(key: key);

  @override
  State<Tweets> createState() => _TweetsState();
}

class _TweetsState extends State<Tweets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(child: Text("Tweets")),
    );
  }
}
