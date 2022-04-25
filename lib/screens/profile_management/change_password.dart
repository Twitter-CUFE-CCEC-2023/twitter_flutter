import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_bloc.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_events.dart';
import 'package:twitter_flutter/blocs/UpdatePasswordStates/updatepassword_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'package:twitter_flutter/screens/profile_management/your_account.dart';
import 'package:twitter_flutter/screens/profile_management/your_account.dart';


class ChangePassword extends StatefulWidget {
  static String route = '/ChangePassword';

  const ChangePassword({Key? key}) : super(key: key);
  changepassword createState() => changepassword();
}

class changepassword extends State<ChangePassword> {
  bool isButtonEnabled = true;
  late TextEditingController password;
  late TextEditingController confirmpassword;
  late TextEditingController pass;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool nextActive = false;
  bool validpassword = false;

  @override
  void dispose() {
    confirmpassword.dispose();
    password.dispose();
    pass.dispose();
    super.dispose();
  }
  Widget Message(
      {required String message,
        required double fontSize,
        required Color colors}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35), // 35
      child: AutoSizeText(
        message,
        style: TextStyle(fontSize: fontSize, color: colors),
        maxLines: 2,
      ),
    );
  }

  Widget textfield(
      {required String message,
        required String message2,
        required double width,
        required TextEditingController controller,
        required validator}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
      child: SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            validator: validator,
            decoration: InputDecoration(
              labelText: message,
              hintText: message2,
            ),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    pass = TextEditingController();
    password = TextEditingController();
    confirmpassword = TextEditingController();
    confirmpassword.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
    password.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
    pass.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
  }

  String? ValidateConfirmpassword(String? value) {
    if (value == null) {
      return 'Please re-enter password';
    }
    if (password.text != confirmpassword.text) {
      return "Password does not match";
    }
    return null;
  }

  String? Validatepassword(String? value) {
    if (value == null) {
      return 'Please Enter password';
    } else if (value.length < 8) {
      return 'Your password needs to be at least 8 characters.\n Please enter a longer one.';
    }
    return null;
  }

  bool DisableButton() {
    if (pass.text.isEmpty ||
        password.text.isEmpty ||
        confirmpassword.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];
    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        sizedBoxHeightMultiplier[0] = 1;
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        fontSizeMultiplier[0] = 2;
      }
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context, false)),
          backgroundColor: Colors.white,
          title: Column(children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Update Password',
                style: TextStyle(
                  fontSize: 0.025 * fontSizeMultiplier[0] * screenHeight,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '@username ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 0.023 * fontSizeMultiplier[0] * screenHeight,
                ),
              ),
            ),
          ]),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: <Widget>[
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      textfield(
                          message: 'Current Password',
                          message2: '',
                          width: screenWidth - 50,
                          controller: pass,
                          validator: Validatepassword),
                      Container(
                        height: 10,
                      ),
                      textfield(
                          message: 'New Password',
                          message2: 'At least 8 characters',
                          width: screenWidth - 50,
                          controller: password,
                          validator: Validatepassword),
                      Container(
                        height: 10,
                      ),
                      textfield(
                        message: 'Confirm Password',
                        message2: 'At least 8 characters',
                        width: screenWidth - 50,
                        controller: confirmpassword,
                        validator: ValidateConfirmpassword,
                      ),
                      Container(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5000),
                        child: SizedBox(
                          width: screenWidth / 2,
                          height: 45,
                          child: BlocListener<UpdatePasswordBloc,
                              UpdatePasswordStates>(
                            listener: (context, state) {
                              if (state is UpdatePasswordSuccessState) {
                                try {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      YourAccount.route,
                                      (Route<dynamic> route) => false);
                                } on Exception catch (e) {
                                  context
                                      .read<UpdatePasswordBloc>()
                                      .add(StartEvent());
                                }
                              } else if (state is UpdatePasswordFailureState) {
                                setState(() {});
                              }
                            },
                            child: RaisedButton(
                              color: Colors.blueAccent,
                              disabledColor: Colors.lightBlueAccent,
                              disabledElevation: 54,
                              child: Text(
                                'Update password',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSizeMultiplier[0]*screenHeight*0.0232,
                                ),
                              ),
                              onPressed: nextActive
                                  ? () {
                                      if (_formkey.currentState!.validate()) {
                                        String oldpassword = pass.text;
                                        String newpassword = confirmpassword.text;
                                        context.read<UpdatePasswordBloc>().add(
                                            UpdatePasswordButtonPressed(
                                                oldpassword: oldpassword,
                                                newpassword: newpassword));
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: screenWidth,
                          height: screenHeight*sizedBoxHeightMultiplier[0]*0.043,
                          child: Center(
                            child: TextButton(
                              onPressed: (){},
                            child : Message(
                                fontSize: 25 ,
                                message: 'Forgot password?',
                                colors: Colors.black54),
                            ),   )),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
      //);
    });
  }
}
