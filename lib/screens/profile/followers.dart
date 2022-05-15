import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/userManagement/user_management_bloc.dart';
import '../../models/objects/user.dart';
import '../../repositories/user_management_repository.dart';
import '../../utils/Web Services/user_management_requests.dart';
class Followers extends StatefulWidget {
  static String route = '/Followers';
  const Followers({Key? key}) : super(key: key);
  @override
  followers createState() => followers();
}
class User {
  final String name;
  final String username;
  final String bio;
  final String image;
  bool isFollowedByMe;

  User(this.name, this.username,this.bio,this.image, this.isFollowedByMe);
}

class followers extends State<Followers> {

  List<User> _users = [
    User('User1', '@username','bio','https://www.royalunibrew.com/wp-content/uploads/2021/07/blank-profile-picture-973460_640-300x300.png', false),
    User('User2', '@username','bio', 'https://www.royalunibrew.com/wp-content/uploads/2021/07/blank-profile-picture-973460_640-300x300.png', false),
    User('User3', '@username','bio', 'https://www.royalunibrew.com/wp-content/uploads/2021/07/blank-profile-picture-973460_640-300x300.png', false),
    User('User4', '@username','bio', 'https://www.royalunibrew.com/wp-content/uploads/2021/07/blank-profile-picture-973460_640-300x300.png', false),
    User('User5', '@username','bio', 'https://www.royalunibrew.com/wp-content/uploads/2021/07/blank-profile-picture-973460_640-300x300.png', false)
  ];


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


    UserManagementBloc userBloc = context.read<UserManagementBloc>();

    Future<FollowModel> model = call_getfollowers(userBloc);
    model == null
        ? log("model is null")
        : log("model is not null");

      // List[UserModel]
      // each user model have username, name ,bio

      // model[i].username , model[i].name , model[i].bio


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


          body: Container(
              padding: EdgeInsets.only(right: 20, left: 20),
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return userComponent(user: _users[index]);
                },
              )
          ),
        ),
      );
      //);
    }
    
    );
    
  }
  
  Future<FollowModel> call_getfollowers(UserManagementBloc bloc) {
    late Future<FollowModel> replay;
    try {
      replay = repo.getFollowing(
          access_token: bloc.access_token,
          username: bloc.userdata.username,
          page: 1,
          count: 5);
    } on Exception catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
      );
    }
    return replay;
  }

  userComponent({required User user}) {
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
                      child: Image.network(user.image),
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
                color: user.isFollowedByMe ? Colors.blue : Colors.white,
                onPressed: () {
                  setState(() {
                    user.isFollowedByMe = !user.isFollowedByMe;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(user.isFollowedByMe ? 'Following' : 'Follow', style: TextStyle(color: user.isFollowedByMe ? Colors.white : Colors.black,fontSize: 16)),
              )
          )
        ],
      ),
    );
  }
}
