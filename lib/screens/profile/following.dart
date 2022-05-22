import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/userManagement/user_management_bloc.dart';
import '../../models/objects/user.dart';
import '../../repositories/user_management_repository.dart';
import '../../utils/Web Services/user_management_requests.dart';
import 'package:twitter_flutter/blocs/cubit/followmanagement_cubit.dart';

class Following extends StatefulWidget {
  static String route = '/Following';
  const Following({Key? key}) : super(key: key);
  @override
  following createState() => following();
}

class following extends State<Following> {
  late List<UserModel> userfollowing;


  UserManagementRepository repo = UserManagementRepository(
      userManagementRequests: UserManagementRequests());



  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return AutoSizeText(
      message,
      style: TextStyle(fontSize: fontSize, color: colors),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userBloc = context.read<UserManagementBloc>();
    FollowmanagementCubit followQubit = context.read<FollowmanagementCubit>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        imageMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        imageMultiplier[0] = 1.8;
        fontSizeMultiplier[0] = 2;
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                ),
                onPressed: () => Navigator.pop(context, false)),
            backgroundColor: Colors.white,
            title: SizedBox.fromSize(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Following',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 0.0255 * fontSizeMultiplier[0] * screenHeight,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,


          body: BlocBuilder<FollowmanagementCubit, FollowmanagementState>(
            builder: (context, state) {
              if (state is FollowmanagementInitial)
                followQubit.onInit(
                    access_token: userBloc.access_token,
                    username: userBloc.userdata.username,
                    count: 10,
                    page: 1);
              if (state is Loading)
                return Text("Loading");
              else if (state is GetFollowingSucess &&
                  state is GetFollowingSucess) {
                List<UserModel> data = followQubit.following;

                return Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    color: Colors.white,
                    height: double.infinity,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return userComponent(user: data[index]);
                      },
                    )
                );
              } else
                return Text("NO DATA");
            },
          ),
        ),

      );
    }

    );
  }

  userComponent({required UserModel user}) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user.profile_image_url),
                    )
                ),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                      SizedBox(height: 5,),
                      Text(user.username, style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 5,),
                      Text(user.bio, style: TextStyle(color: Colors.black)),
                    ]
                )
              ]
          ),
          Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeeeeee)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: MaterialButton(
                elevation: 0,
                 color: user.is_followed? Colors.blue : Colors.white,
                onPressed: () {
                  setState(() {
                       user.is_followed = !user.is_followed;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                 child: Text(user.is_followed? 'Following' : 'Follow', style: TextStyle(color: user.is_followed? Colors.white : Colors.black,fontSize: 16)),
              )
          )
        ],
      ),
    );
  }
}
