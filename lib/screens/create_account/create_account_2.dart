import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';

class CreateAccount2 extends StatefulWidget {
  static String route = '/CreateAccount2';

  const CreateAccount2({Key? key}) : super(key: key);
  createaccount2 createState() => createaccount2();
}

class createaccount2 extends State<CreateAccount2> {
//  const CreateAccount3({Key? key}) : super(key: key);
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

  Widget termConditions({required TextStyle buttons, required TextStyle text}) {
    return Text.rich(
      TextSpan(
          text: 'By signing up, you agree to our ',
          style: text,
          children: <TextSpan>[
            TextSpan(
              text: 'Terms',
              style: buttons,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(
                    context,
                    TermsOfService.route,
                    arguments: WebViewArgs('https://twitter.com/en/tos'),
                  );
                },
            ),
            TextSpan(
                text: ', Privacy Policy and ',
                style: text,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Cookie Use',
                    style: buttons,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(
                          context,
                          TermsOfService.route,
                          arguments: WebViewArgs(
                              'https://help.twitter.com/en/rules-and-policies/twitter-cookies'),
                        );
                      },
                  ),
                ]),
            TextSpan(
                text:
                    '.Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. ',
                style: text,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Learn more',
                    style: buttons,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(
                          context,
                          TermsOfService.route,
                          arguments:
                              WebViewArgs('https://twitter.com/en/privacy'),
                        );
                      },
                  ),
                ])
          ]),
    );
  }

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  late Map<String, String?> data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        imageMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        imageMultiplier[0] = 1.8;
        fontSizeMultiplier[0] = 2;
        // double screenHeight = MediaQuery.of(context).size.height;
        // double screenWidth = MediaQuery.of(context).size.width;
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
                left: 35.0, right: 30.0, top: 20.0, bottom: 10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Message(
                  message: 'Customise your experience',
                  fontSize: 0.038 * fontSizeMultiplier[0] * screenHeight, // 30
                  weight: FontWeight.bold,
                  colors: Colors.black
                  // family: 'IBMPlexSans',
                  ),
              Container(
                height: 30,
              ),
              Message(
                  message: 'Track where you see Twitter content across the web',
                  fontSize: 0.028 * fontSizeMultiplier[0] * screenHeight, // 30
                  weight: FontWeight.bold,
                  colors: Colors.black
                  // family: 'IBMPlexSans',
                  ),
              CheckboxListTile(
                contentPadding: const EdgeInsets.only(
                    left: 0.0, right: 28.0, top: 10.0, bottom: 00.0),
                activeColor: Colors.blue,
                value: value,
                onChanged: (value) => setState(() => this.value = value!),
                title: Message(
                    message:
                        'Twitter uses this data to personlise your experience. This web browsing history will never be stored with your name, email, or phone number.',
                    fontSize:
                        0.021 * fontSizeMultiplier[0] * screenHeight, // 30
                    weight: FontWeight.normal,
                    colors: Colors.black54
                    // family: 'IBMPlexSans',
                    ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 0.0, right: 28.0, top: 10.0, bottom: 20.0),
                child: termConditions(
                  buttons: buttonStyle(
                      0.0188 * screenHeight * fontSizeMultiplier[0]), // 11
                  text: textStyle(
                      0.0188 * screenHeight * fontSizeMultiplier[2]), // 11
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
                width: 80,
                height: 45,
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, '/CreateAccount3', arguments: {
                      'name': data['name'],
                      'email': data['email'],
                      'date': data['date'],
                    });
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
