import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_flutter/screens/authentication/loginUsername.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  static String route = '/';
  // A class to display Appbar with twitter logo to be used multiple times
  AppBar logoAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Center(
        child: Image.asset('assets/images/bluetwitterlogo64.png'),
      ),
    );
  }

  // To display the welcome message on the screen
  Widget welcomeMessage(
      {required String message,
      required double fontSize,
      required FontWeight weight,
      required String family}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: AutoSizeText(
        message,
        style: TextStyle(
            fontSize: fontSize, fontWeight: weight, fontFamily: family),
        maxLines: 3,
      ),
    );
  }

  // To create buttons for signing in with other company
  Widget continueWithButton(
      {required String company,
      required String logo,
      required double imageHeight,
      required double imageWidth}) {
    return InkWell(
      onTap: () {},
      // to make the splash rounded
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 314,
        height: 40,
        decoration: BoxDecoration(

            // to make the button look rounded
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
            shape: BoxShape.rectangle),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Ink.image(
              image: AssetImage(logo),
              height: 40,
              width: 40,
            ),
            const SizedBox(
              height: 0,
              width: 1,
            ),
            Text(
              'Continue with $company',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  // Create account through twitter button
  Widget createButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.black26,
      child: Ink(
        //color: Colors.blue,
        width: 314,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue,
        ),
        child: const Center(
          child: Text(
            'Create account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Column containing all buttons needed
  Widget buttons(BuildContext context) {
    return Column(
      children: <Widget>[
        continueWithButton(
            company: 'Google',
            logo: 'assets/images/googlelogo64.png',
            imageHeight: 40,
            imageWidth: 40),
        SizedBox(
          height: 8,
          width: MediaQuery.of(context).size.width,
        ),
        continueWithButton(
            company: 'Facebook',
            logo: 'assets/images/facebooklogo32.png',
            imageHeight: 30,
            imageWidth: 30),
        SizedBox(
          height: 8,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
              ),
              Text(
                ' Or ',
                style: TextStyle(color: Colors.black26),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black26,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
          width: MediaQuery.of(context).size.width,
        ),
        createButton(),
      ],
    );
  }

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  // Display terms & conditions
  Widget termConditions({required TextStyle buttons, required TextStyle text}) {
    return AutoSizeText.rich(
      TextSpan(
        text: 'By signing up, you agree to our ',
        style: text,
        children: [
          TextSpan(
            text: 'Terms',
            recognizer: TapGestureRecognizer()..onTap = () => {print('hello')},
            style: buttons,
          ),
          TextSpan(
            text: ', ',
            style: text,
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: buttons,
            recognizer: TapGestureRecognizer()..onTap = () => {print('hello')},
          ),
          TextSpan(
            text: ', and ',
            style: text,
          ),
          TextSpan(
            text: 'Cookie Use',
            style: buttons,
            recognizer: TapGestureRecognizer()..onTap = () => {print('hello')},
          ),
          TextSpan(
            text: '.',
            style: text,
          ),
        ],
      ),
    );
  }

  Widget logIn(
      {required TextStyle buttons,
      required TextStyle text,
      required BuildContext context}) {
    return AutoSizeText.rich(
      TextSpan(
        text: 'Have an account already ? ',
        style: text,
        children: [
          TextSpan(
            text: 'Log in',
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => {Navigator.pushNamed(context, LoginUsername.route)},
            style: buttons,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: logoAppBar(),
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 165,
                width: MediaQuery.of(context).size.width,
              ),
              welcomeMessage(
                message: 'See what’s happening in the world right now. ',
                fontSize: 30,
                weight: FontWeight.bold,
                family: 'IBMPlexSans',
              ),
              SizedBox(
                height: 142,
                width: MediaQuery.of(context).size.width,
              ),
              buttons(context),
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: 330,
                child: termConditions(
                  buttons: buttonStyle(14),
                  text: textStyle(14),
                ),
              ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 95, 0),
                child: logIn(
                  buttons: buttonStyle(16),
                  text: textStyle(16),
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //);
  }
}
