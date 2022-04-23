import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';

class VerificationCode extends StatefulWidget {
  static String route = '/VerificationCode';

  const VerificationCode({Key? key}) : super(key: key);
  verificationcode createState() => verificationcode();
}

class verificationcode extends State<VerificationCode> {
  bool value = false;

  AppBar logoAppBar({required double height, required double imageMultiplier}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        onPressed: () => Navigator.pop(context),
      ),
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
    return AutoSizeText(
      message,
      style: TextStyle(fontSize: fontSize, fontWeight: weight, color: colors),
    );
  }

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  @override
  Widget build(BuildContext context) {
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        imageMultiplier[0] = 1;
        borderRadiusMultiplier = 1;
        fontSizeMultiplier[0] = 1;
        fontSizeMultiplier[1] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        imageMultiplier[0] = 1.8;
        fontSizeMultiplier[0] = 2;
        fontSizeMultiplier[1] = 2;
      }

      return SafeArea(
          child: Scaffold(
        appBar: logoAppBar(
            height: screenHeight, imageMultiplier: imageMultiplier[0]),
        //),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Message(
                  message: 'We sent you a code',
                  fontSize: 0.038 * fontSizeMultiplier[0] * screenHeight, // 30
                  weight: FontWeight.bold,
                  colors: Colors.black
                  // family: 'IBMPlexSans',
                  ),
              Container(
                height: 15,
              ),
              Message(
                  message: 'Enter it below to verify example@gmail.com.',
                  fontSize: 0.0182 * fontSizeMultiplier[0] * screenHeight, // 30
                  weight: FontWeight.bold,
                  colors: Colors.grey
                  // family: 'IBMPlexSans',
                  ),
              Container(
                height: 15,
              ),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(hintText: 'Verification code',hintStyle: textStyle(0.0192 * fontSizeMultiplier[0] * screenHeight)
                ),
              ),
              TextButton(
                style:
                    TextButton.styleFrom(primary: Colors.grey // Disable color
                        ),
                onPressed: () {},
                child: Text(
                  "Didn't receive email?",
                  style: TextStyle(color: Colors.blue,
                    fontSize: 0.0172 * fontSizeMultiplier[0] * screenHeight,
                  ),
                ),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: ButtonBar(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5000),
              child: SizedBox(
                width:screenWidth*0.192,
                height: sizedBoxHeightMultiplier[0] *0.05*screenHeight,
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () {},
                  child:  Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sizedBoxHeightMultiplier[0] *0.0192*screenHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
      //);
    });
  }
}
