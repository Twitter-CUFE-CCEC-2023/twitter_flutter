import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_flutter/models/objects/user.dart';

import '../../blocs/userManagement/user_management_bloc.dart';
import '../../blocs/userManagement/user_management_states.dart';
import '../starting_page.dart';

class HomeSideBar extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 10);
  late UserModel userData;

  Future<void> _faildAuthentication(context) async {
    await Future.delayed(Duration(seconds: 0)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, StartingPage.route, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<UserManagementBloc>();

    if (bloc.state is LoginSuccessState) {
      userData = bloc.userdata;
    } else {
      return FutureBuilder(
          builder: (context, _) {
            return Container(
              color: Colors.lightBlue,
            );
          },
          future: _faildAuthentication(context));
    }
    return Drawer(
      child: ListView(
        padding: padding,
        children: [
          avatarIcon(context, "/userProfile"),
          buildtext(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          const Divider(
            thickness: 1,
            height: 15,
          ),
          const Divider(
            thickness: 1,
            height: 10,
          ),
          buildMenuIem(FontAwesomeIcons.user, 'Profile', context,
              route: "/userProfile"),
          buildMenuIem(FontAwesomeIcons.list, 'Lists', context),
          buildMenuIem(FontAwesomeIcons.comment, 'Topics', context),
          buildMenuIem(FontAwesomeIcons.bookmark, 'Bookmarks', context),
          buildMenuIem(FontAwesomeIcons.bolt, 'Moments', context),
          buildMenuIem(Icons.monetization_on, 'Monestisation', context),
          const Divider(thickness: 1),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.5)),
          buildMenuIem(Icons.near_me, "Twitter for Professionals", context),
          const Divider(thickness: 1),
          textItem('Settings and Privacy', context, route: "/Settings"),
          textItem('Help Center', context),
          logOutButton('Logout', context),
        ],
      ),
    );
  }

  Widget logOutButton(String title, BuildContext context, {String? route}) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 125, 119, 119))),
      onTap: () {
        //Update Login Bloc to add LogOut State
        Navigator.pushNamedAndRemoveUntil(
            context, "/", (Route<dynamic> route) => false);
      },
    );
  }

  Widget textItem(String title, BuildContext context, {String? route}) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 125, 119, 119))),
      onTap: () {
        if (route != null) {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  Widget buildMenuIem(IconData icon, String title, BuildContext context,
      {String? route}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Transform.translate(
        offset: const Offset(-15, 0),
        child: Text(title,
            style: const TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 125, 119, 119))),
      ),
      onTap: () {
        if (route != null) {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  Widget avatarIcon(BuildContext context, String route) {
    return Padding(
      padding: const EdgeInsets.only(right: 200, top: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, route);
        },
        child: SizedBox(
          width: 60,
          height: 60,
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                (userData.profile_image_url != "")
                    ? userData.profile_image_url
                    : "https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png",
              ),
              radius: 5,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildtext() {
    return Padding(
      padding: const EdgeInsets.only(left: 17, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userData.name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            "@" + userData.username,
            style: const TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 125, 119, 119)),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(children: [
            Text(
              userData.following_count.toString(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              " Following",
              style: TextStyle(color: Color.fromARGB(255, 125, 119, 119)),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              userData.followers_count.toString(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              " Following",
              style: TextStyle(color: Color.fromARGB(255, 125, 119, 119)),
            ),
          ])
        ],
      ),
    );
  }
}
