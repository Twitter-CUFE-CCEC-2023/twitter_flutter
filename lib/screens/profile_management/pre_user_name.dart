import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/screens/profile/edit_profile.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/screens/profile_management/user_name.dart';

class PreUsername extends StatelessWidget {
  const PreUsername({Key? key}) : super(key: key);
  static String route = '/PreUsername';

  @override
  Widget build(BuildContext context) {
    var state = context.watch<UserManagementBloc>().state;
    if (state is LoginSuccessState) {
      return FutureBuilder(
        future: _userName(state, context),
        builder: (context, ss) {
          return Container(
            color: Colors.lightBlue,
          );
        },
      );
    } else {
      return Container();
    }
  }

  Future<String> _userName(LoginSuccessState state, context) async {
    await Future.delayed(Duration(seconds: 0))
        .then((value) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserName(
          user_name: state.userdata.username,
        ),),),);
    return "";
  }
}
