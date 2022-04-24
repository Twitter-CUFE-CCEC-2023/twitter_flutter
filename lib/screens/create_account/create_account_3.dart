// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';

class CreateAccount3 extends StatefulWidget {
  const CreateAccount3({Key? key}) : super(key: key);

  static String route = '/CreateAccount3';

  @override
  State<CreateAccount3> createState() => _CreateAccount3State();
}

class _CreateAccount3State extends State<CreateAccount3> {
  late String createAccountStr;
  late double screenHeight;

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  late Map<String, String?> data;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    createAccountStr = "Create your \naccount";
    data = ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        createAccountStr = "Create your \naccount";
      } else {
        createAccountStr = "Create your account";
      }

      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          appBar: MyAppBar(),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createAccountText(),
                infoField(data['name']),
                infoField(data['email']),
                infoField(data['dateShow']),
                Padding(
                    padding: EdgeInsets.fromLTRB(35, 60, 30, 0),
                    child: termConditions(
                      buttons: buttonStyle(19), // 11
                      text: textStyle(19),
                    )),
                nextButton(),
                Padding(padding: EdgeInsets.only(bottom: 50)),
              ],
            ),
          ),
        )),
      );
    });
  }

  PreferredSizeWidget MyAppBar() => AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/twitter_logo.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
  Widget createAccountText() => Padding(
        padding: EdgeInsets.only(
            left: 30,
            bottom: 30,
            top: 0.025 * screenHeight), //left = 30, top = 20
        child: Text(
          createAccountStr,
          style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
        ),
      );
  Widget infoField(String? data) => Padding(
        padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(
                  hintText: data,
                  hintStyle: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))),
            )),
      );
  Widget nextButton() => Container(
        margin: const EdgeInsets.only(top: 10, left: 45),
        width: MediaQuery.of(context).size.width - 80,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/CreateAccount4', arguments: data);
            },
            child: const Text("Sign Up"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))))),
      );
  Widget termConditions({required TextStyle buttons, required TextStyle text}) {
    return AutoSizeText.rich(
      TextSpan(
        text: 'By signing up, you agree to our ',
        style: text,
        children: [
          TextSpan(
            text: 'Terms of Service',
            recognizer: TapGestureRecognizer()
              ..onTap = () => {
                    Navigator.pushNamed(context, TermsOfService.route,
                        arguments: WebViewArgs('https://twitter.com/en/tos')),
                  },
            style: buttons,
          ),
          TextSpan(
            text: ' and Privacy Policy, including ',
            style: text,
          ),
          TextSpan(
            text: 'Cookie Use',
            style: buttons,
            recognizer: TapGestureRecognizer()
              ..onTap = () => {
                    Navigator.pushNamed(context, TermsOfService.route,
                        arguments: WebViewArgs(
                            'https://help.twitter.com/en/rules-and-policies/twitter-cookies')),
                  },
          ),
          TextSpan(
            text:
                '. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalising our services, including ads. ',
            style: text,
          ),
          TextSpan(
            text: 'Learn more',
            style: buttons,
            recognizer: TapGestureRecognizer()
              ..onTap = () => {
                    Navigator.pushNamed(context, TermsOfService.route,
                        arguments:
                            WebViewArgs('https://twitter.com/en/privacy/')),
                  },
          ),
          TextSpan(
            text:
                '. Others will be able to find you by email or phone number, when provided, unless you choose otherwise ',
            style: text,
          ),
          TextSpan(
            text: 'here',
            style: buttons,
            recognizer: TapGestureRecognizer()
              ..onTap = () => {
                    //TODO: CALL COOKIE USE PAGE
                  },
          ),
          TextSpan(
            text: ".",
            style: text,
          )
        ],
      ),
    );
  }
}
