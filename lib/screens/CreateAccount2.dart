// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CreateAccount2 extends StatefulWidget {
  const CreateAccount2({Key? key}) : super(key: key);

  static String route = '/CreateAccount2';

  @override
  State<CreateAccount2> createState() => _CreateAccount2State();
}

class _CreateAccount2State extends State<CreateAccount2> {
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
                    //TODO: CALL TERMS AND CONDITIONS PAGE
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
                    //TODO: CALL PRIVACY POLICY PAGE
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
                    //TODO: CALL COOKIE USE PAGE
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

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size);
  }

  late Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String createAccountStr = "Create your \naccount";
    return OrientationBuilder(builder: (context, orientation) {
      print(MediaQuery.of(context).size.height); //782

      if (orientation == Orientation.portrait) {
        createAccountStr = "Create your \naccount";
      } else {
        createAccountStr = "Create your account";
      }
      data = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
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
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 30,
                      top: 0.025 * screenHeight), //left = 30, top = 20
                  child: Text(
                    createAccountStr,
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 30, 0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: data['name'],
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 88, 85, 85))),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: data['email'],
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 88, 85, 85))),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: data['date'],
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 88, 85, 85))),
                      )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(35, 60, 30, 0),
                    child: termConditions(
                      buttons: buttonStyle(19), // 11
                      text: textStyle(19),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 45),
                  width: MediaQuery.of(context).size.width - 80,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/CreateAccount4');
                      },
                      child: const Text("Sign Up"),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))))),
                ),
                Padding(padding: EdgeInsets.only(bottom: 50)),
              ],
            ),
          ),
        )),
      );
    });
  }
}
