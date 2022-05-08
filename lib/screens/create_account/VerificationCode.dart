import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';
import 'package:twitter_flutter/screens/profile_management/your_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_flutter/blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';

class VerificationCode extends StatefulWidget {
  static String route = '/VerificationCode';

  const VerificationCode({Key? key}) : super(key: key);
  verificationcode createState() => verificationcode();
}

class verificationcode extends State<VerificationCode> {
  bool value = false;
  late TextEditingController _codefield;
  bool nextActive = false;

  @override
  void initState() {
    super.initState();
    _codefield = TextEditingController();
    _codefield.addListener(() {
      setState(() {
        nextActive = DisableButton();
      });
    });
  }

  bool DisableButton() {
    if (_codefield.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Widget logoBottmBar(
      {required double width, required double height, required double size}) {
    return ButtonBar(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5000),
          child: SizedBox(
            width: width,
            height: height,
            child: ElevatedButton(
              onPressed: DisableButton() ? () {} : null,
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size,
                ),
              ),
              style: elevatedButtonsStyle,
            ),
          ),
        ),
      ],
    );
  }

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
        fontSizeMultiplier[0] = 1;
      } else {
        sizedBoxHeightMultiplier[0] = .1;
        imageMultiplier[0] = 1.8;
        fontSizeMultiplier[0] = 2;
      }

      return SafeArea(
          child: Scaffold(
        appBar: logoAppBar(
            height: screenHeight, imageMultiplier: imageMultiplier[0]),
        bottomNavigationBar: logoBottmBar(
            width: screenWidth * 0.192,
            height: sizedBoxHeightMultiplier[0] * 0.05 * screenHeight,
            size: sizedBoxHeightMultiplier[0] * 0.0192 * screenHeight),
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _codefield,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Verification code',
                    hintStyle: textStyle(
                        0.0192 * fontSizeMultiplier[0] * screenHeight)),
              ),
              BlocListener<UserManagementBloc, UserManagementStates>(
                  listenWhen: (prevState, currentState) =>
                      currentState is VerificationSuccessState ||
                      currentState is VerificationFailureState,
                  listener: (context, state) {
                    if (state is VerificationSuccessState) {
                      try {
                        var bloc = context.watch<UserManagementBloc>();
                        Navigator.pushNamedAndRemoveUntil(context,
                            HomePage.route, (Route<dynamic> route) => false);
                      } on Exception catch (e) {
                        context.read<UserManagementBloc>().add(StartEvent());
                      }
                    } else if (state is VerificationFailureState) {}
                  },
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.grey // Disable color
                        ),
                    onPressed: nextActive
                        ? () {
                            int VerificationCode = int.parse(_codefield.text);
                            context.read<UserManagementBloc>().add(
                                VerificationButtonPressed(
                                    verificationCode: VerificationCode));
                          }
                        : null,
                    child: Text(
                      "Didn't receive email?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 0.0172 * fontSizeMultiplier[0] * screenHeight,
                      ),
                    ),
                  ))
            ]),
          ),
        ),
      ));
      //);
    });
  }
}
