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
import 'package:country_code_picker/country_code_picker.dart';

class ChangePhone extends StatefulWidget {
  static String route = '/ChangePhone';
  const ChangePhone({Key? key}) : super(key: key);
  changephone createState() => changephone();
  }


class changephone extends State<ChangePhone> {
  bool value = false;
  late UserModel userData;
  late TextEditingController _phonefield;
  bool nextActive = false;
  Icon phoneCheckSuffix = const Icon(null);
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phonefield = TextEditingController();
    _phonefield.addListener(() {
      phoneCheckSuffix = ValidatePhone(_phonefield.text)
          ? const Icon(
              Icons.check_circle_outline_sharp,
              size: 25.0,
              color: Color(0xFF2DB169),
            )
          : const Icon(null);
      setState(() {
        nextActive = DisableButton();
      });
    });
  }

  bool DisableButton() {
    if (_phonefield.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phonefield.dispose();
  }

  Widget PhoneField() => Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 10, 10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              validator: (Value) {
                if (ValidatePhone(_phonefield.text)) {
                  return null;
                } else {
                  return "Enter Valid Phone number";
                }
              },
              controller: _phonefield,
              decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (phoneCheckSuffix.icon != null) phoneCheckSuffix, // c
                    ],
                  ),
                  hintStyle: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 88, 85, 85))),
            )),
      );

  ButtonStyle elevatedButtonsStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.blue.shade300;
      } else {
        return Colors.blue;
      }
    }),
    foregroundColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.blue.shade300;
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
      elevation: 0,
      automaticallyImplyLeading: false,
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

  Widget CheckboxText({required TextStyle buttons, required TextStyle text}) {
    return Text.rich(
      TextSpan(
          text:
              'Let people who have your phone number find and connect with you on Twitter. ',
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
                    arguments: WebViewArgs('https://twitter.com/en/tos'),
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
        imageMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        imageMultiplier[0] = 1.8;
        fontSizeMultiplier[0] = 2;
      }

      return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 0.0, top: 0.0, bottom: 0.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 0.0233 * fontSizeMultiplier[0] * screenHeight),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth - 162, right: 0.0, top: 0.0, bottom: 0.0),
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
                                    arguments: {

                                    });
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
                ),
              ),
            ],
          ),
          appBar: logoAppBar(
              height: screenHeight, imageMultiplier: imageMultiplier[0]),
          //),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Message(
                        message: 'Add phone number',
                        fontSize:
                            0.046 * fontSizeMultiplier[0] * screenHeight, // 30
                        weight: FontWeight.bold,
                        colors: Colors.black
                        // family: 'IBMPlexSans',
                        ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 0.0),
                      child: Message(
                          message:
                              "Enter the phone number you'd like to associate with your Twitter account. You'll get a verification code sent here",
                          fontSize: 0.0212 *
                              fontSizeMultiplier[0] *
                              screenHeight, // 30
                          weight: FontWeight.bold,
                          colors: Colors.black54
                          // family: 'IBMPlexSans',
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CountryCodePicker(
                        initialSelection: 'EG',
                        alignLeft: true,
                        showDropDownButton: true,
                      ),
                    ),
                    Form(
                      key: _formkey,
                      child: PhoneField(),
                    ),
                    CheckboxListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 0.0, right: 28.0, top: 10.0, bottom: 0.0),
                      activeColor: Colors.blue,
                      value: value,
                      onChanged: (value) => setState(() => this.value = value!),
                      title: CheckboxText(
                        buttons: buttonStyle(
                            0.021 * fontSizeMultiplier[0] * screenHeight), // 11
                        text: textStyle(
                            0.021 * fontSizeMultiplier[0] * screenHeight), // 11
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

bool ValidatePhone(String p) {
  RegExp regPhone = RegExp(r"^01[0-2,5]{1}[0-9]{8}$");
  return regPhone.hasMatch(p);
}
