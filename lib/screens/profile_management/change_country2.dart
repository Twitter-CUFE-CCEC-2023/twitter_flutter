import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'account_information.dart';

class ChangeCountry2 extends StatefulWidget {
  static String route = '/ChangeCountry2';

  const ChangeCountry2({Key? key}) : super(key: key);
  changecountry2 createState() => changecountry2();
}

class changecountry2 extends State<ChangeCountry2> {




  AppBar logoAppBar({required double height, required double imageMultiplier}) {
    return AppBar(

      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () => Navigator.pop(context, false)),
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
        required FontWeight weight,
        required Color colors}) {
    return AutoSizeText(message,
      textAlign: TextAlign.center,

      style: TextStyle(fontSize: fontSize, fontWeight: weight, color: colors),
    );
  }



  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size,fontWeight: FontWeight.bold);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size,fontWeight: FontWeight.bold);
  }

  ButtonStyle elevatedButtonsStyle = ButtonStyle(
    backgroundColor:
    MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return  Colors.blue.shade300;
      } else {
        return Colors.blue;
      }
    }),
    foregroundColor:
    MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return  Colors.blue.shade300;
      } else {
        return Colors.white;
      }
    }),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<double> imageMultiplier = [1, 1];
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        fontSizeMultiplier[0] = 1;
      } else {
        fontSizeMultiplier[0] = 2;
      }

      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
              appBar: logoAppBar(
                  height: screenHeight, imageMultiplier: imageMultiplier[0]),
              //),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                  padding: const EdgeInsets.only(
                   right: 0.0, top: 30.0, bottom: 0.0),
                  child:Column(
                      children: <Widget>[
                        Message(
                            message: 'Change country?',
                            fontSize:
                            0.046 * fontSizeMultiplier[0] * screenHeight, // 30
                            weight: FontWeight.bold,
                            colors: Colors.black
                          // family: 'IBMPlexSans',
                        ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20,
                            right: 20.0, top: 30.0, bottom: 30.0),
                        child: Message(
                            message: 'This will customize your Twitter experience based on the country you live in.',
                            fontSize:
                            0.0233 * fontSizeMultiplier[0] * screenHeight, // 30
                            weight: FontWeight.bold,
                            colors: Colors.black54
                        ),
                    ),
                    SizedBox(
                        width: screenWidth*0.85,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Account.route);
                          },
                          child:  Text(
                            'Change',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:  0.0323 * fontSizeMultiplier[0] * screenHeight,
                            ),
                          ),
                          style: elevatedButtonsStyle,
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0.0, top: 10.0, bottom: 0.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child:  Text(
                              'Cancel',
                              style: TextStyle(fontSize: 0.0323 * fontSizeMultiplier[0] * screenHeight),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            )),
      ));
      //);
    });
  }
}

bool ValidateEmail(String p) {
  RegExp regMail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return regMail.hasMatch(p);
}
