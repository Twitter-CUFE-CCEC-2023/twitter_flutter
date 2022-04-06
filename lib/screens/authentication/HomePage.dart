import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:twitter_flutter/screens/authentication/Icons.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static String route = '/HomePage';

  BottomNavigationBar Bottom(
      {required double height, required double imageMultiplier}) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.download,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.saved,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp.home,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            backgroundColor: Colors.black,
            label: 'Notification'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_outline,
              size: 0.033 * imageMultiplier * height,
              color: Colors.black,
            ),
            backgroundColor: Colors.black,
            label: 'Messages'),
      ],
    );
  }

  AppBar logoAppBar({required double height, required double imageMultiplier}) {
    return AppBar(
      elevation: 1,
      actions: [
        IconButton(
          icon: Icon(
            Icons.star_border,
            size: 0.038 * imageMultiplier * height,
          ),
          onPressed: () => {},
        )
      ],
      leading: IconButton(
        onPressed: () => {},
        icon: Icon(
          Icons.circle,
          color: Colors.blue,
          size: 0.038 * imageMultiplier * height,
        ),
      ),
      backgroundColor: Colors.white,
      title: Image.asset(
        'assets/images/bluetwitterlogo64.png',
        width: 0.083 * imageMultiplier * height, // 65
        height: 0.083 * imageMultiplier * height, // 65
        cacheHeight: 70,
      ),

      //systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
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

  @override
  Widget build(BuildContext context) {
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      print(MediaQuery.of(context).size.width);
      print(MediaQuery.of(context).size.height);

      if (orientation == Orientation.portrait) {
        imageMultiplier[0] = 1;
        imageMultiplier[1] = 1;
        borderRadiusMultiplier = 1;
        fontSizeMultiplier[0] = 1;
        fontSizeMultiplier[1] = 1;
        fontSizeMultiplier[2] = 1;
        fontSizeMultiplier[3] = 1;
      } else {
        imageMultiplier[0] = 1.8;
        imageMultiplier[1] = 1.8;
        borderRadiusMultiplier = 1.4;
        fontSizeMultiplier[0] = 2;
        fontSizeMultiplier[1] = 2;
        fontSizeMultiplier[2] = 2;
        fontSizeMultiplier[3] = 2;
      }
      return SafeArea(
        child: Scaffold(
          appBar: logoAppBar(
              height: screenHeight, imageMultiplier: imageMultiplier[0]),
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 30.0, top: 20.0, bottom: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Message(
                        message: 'In progress...',
                        colors: Colors.black,
                        fontSize: 0.038 * fontSizeMultiplier[0] * screenHeight)
                  ]),
            ),
          ),
          bottomNavigationBar:
              Bottom(height: screenHeight, imageMultiplier: imageMultiplier[0]),
        ),
      );
    });
  }
}
