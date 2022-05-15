import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/screens/profile/search_page2.dart';
import 'package:twitter_flutter/screens/utility_screens/home_side_bar.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/widgets/profile/logged_FAB_actions.dart';
import 'package:twitter_flutter/screens/starting_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static String route = '/SearchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late UserModel userData;

  Widget textfieldController({
    required int lines,
    required double width,
    required TextEditingController controller,
    required double fontSizeMultiplier,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: SizedBox(
          width: width*3/4,
          height: 34,
          child: TextFormField(
            enabled: true,
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: lines,
            decoration: InputDecoration(
              hintText: 'Search Twitter',
                hintStyle: TextStyle(color: Colors.blue),
                contentPadding: const EdgeInsets.all(5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          )),
    );
  }


  AppBar logoAppBar(
      {required double height,
        required double imageMultiplier,
        required BuildContext context,
        required String imageUrl}) {
    return AppBar(
      elevation: 0,
      bottom: TabBar(
        indicatorWeight: 3  ,
      indicatorColor: Colors.lightBlue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.blueGrey,
      isScrollable: true,
      labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
      tabs: [


        Tab(text: 'For you',),
        Tab(text: 'Trending',),
        Tab(text: 'COVID-19',),
        Tab(text: 'News',),
        Tab(text: 'Sports',),
        Tab(text: 'Entertainment',),
      ],),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings_sharp,
            color: Colors.blue,
            size: 0.038 * imageMultiplier * height,
          ),
          onPressed: () => {},
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: GestureDetector(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: SizedBox(
            width: 20,
            height: 20,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Padding(
      padding: const EdgeInsets.only(left: 10),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: SizedBox(
              width: 3000,
              height: 32,
            child: ElevatedButton(onPressed: () {
              Navigator.pushNamed(
                  context, SearchPage2.route);},

                child: Align(
                  alignment: Alignment.centerLeft,
                  child:Text('Search Twitter',style: TextStyle(fontSize: 16,color: Colors.blueGrey),textAlign: TextAlign.start,),),
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {return Colors.grey.shade300;}),splashFactory:  NoSplash.splashFactory

            )),

    )))));
  }

  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return AutoSizeText(
      message,
      style: TextStyle(fontSize: fontSize, color: colors),
    );
  }

  Future<void> _faildAuthentication(context) async {
    await Future.delayed(Duration(seconds: 0)).then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, StartingPage.route, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<UserManagementBloc>();

    if (bloc.state is LoginSuccessState ||
        bloc.state is VerificationSuccessState) {
      userData = bloc.userdata;
    } else {
      return FutureBuilder(
          builder: (context, _) {
            return Container(
              color: Colors.lightBlue,
            );
          },
          future: _faildAuthentication(context));

      //TODO:Log the user out in case of the state is not login success or the access token is expired
    }
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];

    return DefaultTabController(
        length: 6,
     child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: HomeSideBar(),
            appBar: logoAppBar(
              height: screenHeight,
              imageMultiplier: imageMultiplier[0],
              context: context,
              imageUrl: (userData.profile_image_url != "")
                  ? userData.profile_image_url
                  : "https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png",
            ),
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  builder: (context) {
                    return GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 0.97 * MediaQuery.of(context).size.height,
                          color: Color(0xDFFFFFFF),
                          child: FABActions(),
                        ));
                  },
                  context: context,
                  backgroundColor: Colors.white24,
                  isDismissible: true,
                  isScrollControlled: true,
                );
              },
              child: Icon(Icons.add),
            ),
            body: Column(),

          ),
        )));
  }
}
