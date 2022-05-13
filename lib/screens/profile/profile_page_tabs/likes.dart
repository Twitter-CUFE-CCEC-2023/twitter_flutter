import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/tweetsManagement/tweets_management_events.dart';
import '../../../blocs/tweetsManagement/tweets_managment_bloc.dart';
import '../../../blocs/tweetsManagement/tweets_managment_states.dart';
import '../../../blocs/userManagement/user_management_bloc.dart';
import '../../../models/objects/tweet.dart';
import '../../../widgets/tweet.dart';

class Likes extends StatefulWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
