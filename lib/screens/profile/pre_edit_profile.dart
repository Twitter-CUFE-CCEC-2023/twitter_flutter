import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/screens/profile/edit_profile.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';

class PreEditProfile extends StatelessWidget {
  const PreEditProfile({Key? key}) : super(key: key);
  static String route = '/PreEditProfile';

  @override
  Widget build(BuildContext context) {
    var state = context.watch<UserManagementBloc>().state;
    if (state is LoginSuccessState) {
      return FutureBuilder(
        future: _editProfile(state, context),
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

  Future<String> _editProfile(LoginSuccessState state, context) async {
    await Future.delayed(Duration(seconds: 0))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EditProfile(
                      name: state.userdata.name,
                      bio: state.userdata.bio,
                      birth_date: state.userdata.birth_date,
                      location: state.userdata.location,
                      website: state.userdata.website,
                    ))));
    return "";
  }
}
