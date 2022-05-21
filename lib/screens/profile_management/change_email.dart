import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';
import 'package:twitter_flutter/models/objects/user.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/userManagement/user_management_bloc.dart';
import '../../blocs/userManagement/user_management_states.dart';
import '../starting_page.dart';
import 'package:twitter_flutter/screens/profile_management/account_information.dart';

class ChangeEmail extends StatefulWidget {
  static String route = '/ChangeEmail';

  const ChangeEmail({Key? key}) : super(key: key);
  changeEmail createState() => changeEmail();
}

class changeEmail extends State<ChangeEmail> {
  bool value = false;
  late UserModel userData;
  late TextEditingController _emailfield;
  bool nextActive = false;
  Icon emailCheckSuffix = const Icon(null);
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailfield = TextEditingController();
    _emailfield.addListener(() {
      emailCheckSuffix = ValidateEmail(_emailfield.text)
          ? const Icon(
              Icons.check_circle_outline_sharp,
              size: 25.0,
              color: Color(0xFF2DB169),
            )
          : const Icon(null);
      setState(() {
        nextActive = disableButton();
      });
    });
  }

  bool disableButton() {
    if (_emailfield.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailfield.dispose();
  }

  Widget emailField() => Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              validator: (value) {
                if (ValidateEmail(_emailfield.text)) {
                  return null;
                } else {
                  return "Enter Valid Email";
                }
              },
              controller: _emailfield,
              decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (emailCheckSuffix.icon != null) emailCheckSuffix, // c
                    ],
                  ),
                  hintText: "Email address",
                  hintStyle: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))),
            )),
      );

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

  AppBar logoAppBar({required double height, required double imageMultiplier}) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
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
      required FontWeight weight,
      required Color colors}) {
    return AutoSizeText(
      message,
      style: TextStyle(fontSize: fontSize, fontWeight: weight, color: colors),
    );
  }

  Widget checkboxtext({required TextStyle buttons, required TextStyle text}) {
    return Text.rich(
      TextSpan(
          text:
              'Let people who have email address find and connect with you on Twitter. ',
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
                    arguments: WebViewArgs('https://help.twitter.com/en/safety-and-security/email-and-phone-discoverability-settings'),
                  );
                },
            ),
          ]),
    );
  }

  TextStyle buttonStyle(double size) {
    return TextStyle(color: Colors.lightBlue, fontSize: size,fontWeight: FontWeight.bold);
  }

  TextStyle textStyle(double size) {
    return TextStyle(color: Colors.black54, fontSize: size,fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<UserManagementBloc>().state;

    if (state is LoginSuccessState) {
      userData = state.userdata;
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, StartingPage.route, (route) => false);
    }
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
          floatingActionButton:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 0.0, top: 0.0, bottom: 0.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:  Text(
                  'Cancel',
                  style: TextStyle(fontSize: 0.0233 * fontSizeMultiplier[0] * screenHeight),
                ),
              ),
            ),
          Padding(
              padding:  EdgeInsets.only(
                  left: screenWidth-162, right: 0.0, top: 0.0, bottom: 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 70,
                height: 32,
                child: ElevatedButton(
                  onPressed: nextActive
                      ? () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.pushNamed(context, Account.route,
                                arguments: {});
                          }
                        }
                      : null,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  style: elevatedButtonsStyle,
                ),
              ),
            )),
          ]),
          appBar: logoAppBar(
              height: screenHeight, imageMultiplier: imageMultiplier[0]),
          //),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 0.0, top: 0.0, bottom: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Message(
                        message: 'Change email',
                        fontSize:
                            0.032 * fontSizeMultiplier[0] * screenHeight, // 30
                        weight: FontWeight.bold,
                        colors: Colors.black
                        // family: 'IBMPlexSans',
                        ),
                    Container(
                      height: 10,
                    ),
                    Message(
                        message: 'Your current email is' +
                            userData.email.toString() +
                            '. What would you like to update to? Your email is not displayed in your public profile on Twitter.',
                        fontSize:
                            0.021 * fontSizeMultiplier[0] * screenHeight, // 30
                        weight: FontWeight.bold,
                        colors: Colors.black54
                        ),
                    Form(
                      key: _formkey,
                      child: emailField(),
                    ),
                    CheckboxListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 0.0, right: 28.0, top: 10.0, bottom: 00.0),
                      activeColor: Colors.blue,
                      value: value,
                      onChanged: (value) => setState(() => this.value = value!),
                      title: checkboxtext(
                        buttons: buttonStyle(0.0212 * fontSizeMultiplier[0] * screenHeight), // 11
                        text: textStyle(0.0212 * fontSizeMultiplier[0] * screenHeight,), // 11
                      ),
                    ),
                  ]),
            ),
          ),
        )),
      );
      //);
    });
  }
}

bool ValidateEmail(String p) {
  RegExp regMail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return regMail.hasMatch(p);
}
