import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_bloc.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_events.dart';
import 'package:twitter_flutter/blocs/userManagement/user_management_states.dart';
import 'package:twitter_flutter/models/google_sign_in.dart';
import 'package:twitter_flutter/screens/authentication/login_username.dart';
import 'package:twitter_flutter/screens/profile/home_page.dart';
import '../blocs/InternetStates/internet_cubit.dart';
import 'package:twitter_flutter/utils/local_db/boxes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twitter_flutter/screens/profile_management/terms_of_service.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  static String route = '/';

  // A class to display Appbar with twitter logo to be used multiple times
  AppBar logoAppBar({required double height, required double imageMultiplier}) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Center(
        child: Image.asset(
          'assets/images/bluetwitterlogo64.png',
          width: 0.083 * imageMultiplier * height, // 65
          height: 0.083 * imageMultiplier * height, // 65
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 35), // 35
      child: AutoSizeText(
        message,
        style: TextStyle(
            fontSize: fontSize, fontWeight: weight, fontFamily: family),
        maxLines: 2,
      ),
    );
  }

  Future signIn() async {
    //await GoogleSignInApi.login();
  }

  // To create buttons for signing in with other company
  Widget continueWithButton(
      {required String company,
      required String logo,
      required double imageHeight,
      required double imageWidth,
      required double borderRadius,
      required double fontSize}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: InkWell(
        onTap: () {
          //TODO: Create google sign in controller
          //signIn();
        },
        // to make the splash rounded
        borderRadius: BorderRadius.circular(borderRadius), // 30
        child: Container(
          decoration: BoxDecoration(
              // to make the button look rounded
              borderRadius: BorderRadius.circular(borderRadius), // 30
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
                height: imageHeight, // 40
                width: imageWidth, // 40
              ),
              Text(
                'Continue with $company',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: fontSize), //16
              )
            ],
          ),
        ),
      ),
    );
  }

  // Create account through twitter button
  Widget createButton(
      {required BuildContext context,
      required double height,
      required double borderRadius,
      required double fontSize}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/CreateAccount1");
        },
        borderRadius: BorderRadius.circular(borderRadius), // 30
        splashColor: Colors.black26,
        child: Ink(
          height: height, // 40
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius), // 30
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              'Create account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize, // 16
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Column containing all buttons needed
  Widget buttons(
      {required BuildContext context,
      required double height,
      required double imageMultiplier,
      required double borderRadiusMultiplier,
      required double fontMultiplier}) {
    return Column(
      children: <Widget>[
        continueWithButton(
            company: 'Google',
            logo: 'assets/images/googlelogo64.png',
            imageHeight: 0.0512 * imageMultiplier * height, //40
            imageWidth: 0.0512 * imageMultiplier * height,
            borderRadius: 0.038 * height * borderRadiusMultiplier, // 30
            fontSize: 0.0205 * fontMultiplier * height),
        SizedBox(
          height: 0.00512 * height, // 4
          width: MediaQuery.of(context).size.width,
        ),
        /*continueWithButton(
            company: 'Facebook',
            logo: 'assets/images/facebooklogo32.png',
            imageHeight: 30, //30
            imageWidth: 30),
        SizedBox(
          height: 8, // 8
          width: MediaQuery.of(context).size.width,
        ),*/
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
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
          height: 0.00512 * height, // 4
          width: MediaQuery.of(context).size.width,
        ),
        createButton(
          context: context,
          height: 0.0512 * imageMultiplier * height,
          borderRadius: 0.038 * height * borderRadiusMultiplier,
          fontSize: 0.0205 * fontMultiplier * height,
        ),
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
  Widget termConditions(
      {required BuildContext context,
      required TextStyle buttons,
      required TextStyle text}) {
    return AutoSizeText.rich(
      TextSpan(
        text: 'By signing up, you agree to our ',
        style: text,
        children: [
          TextSpan(
            text: 'Terms',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(
                  context,
                  TermsOfService.route,
                  arguments: WebViewArgs('https://twitter.com/en/tos'),
                );
              },
            style: buttons,
          ),
          TextSpan(
            text: ', ',
            style: text,
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: buttons,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(
                  context,
                  TermsOfService.route,
                  arguments: WebViewArgs('https://twitter.com/en/privacy'),
                );
              },
          ),
          TextSpan(
            text: ', and ',
            style: text,
          ),
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
    var bloc = context.watch<UserManagementBloc>();
    if (bloc.state is InitState) {
      context.read<UserManagementBloc>().add(StartEvent());
    }

    final List<double> sizedBoxHeightMultiplier = [1, 1, 1, 1];
    final List<double> imageMultiplier = [1, 1];
    final double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusMultiplier = 1;
    final List<double> fontSizeMultiplier = [1, 1, 1, 1];

    return BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
      if (state is InternetDisconnected) {
        return Container(
            color: Colors.white,
            child: SafeArea(
                child: Scaffold(
                    appBar: logoAppBar(
                        height: screenHeight,
                        imageMultiplier: imageMultiplier[0]),
                    backgroundColor: Colors.white,
                    body: const Center(
                      child: Text(
                        "Try Connecting to a Network",
                        style: TextStyle(fontSize: 40.0),
                        textAlign: TextAlign.center,
                      ),
                    ))));
      } else if (state is InternetLoading) {
        return Container(
            color: Colors.white,
            child: const SpinKitRing(
              lineWidth: 6.0,
              size: 70.0,
              color: Colors.white,
            ));
      }
      return BlocConsumer<UserManagementBloc, UserManagementStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacementNamed(
                  context, HomePage.route);
            }
          },
          builder: (context, state) {
        //Handling the user already logged in
        if (state is LoadingState) {
          return Container(
            color: Colors.lightBlue,
            child: SpinKitRing(
              lineWidth: 6.0,
              size: 70.0,
              color: Colors.white,
            ),
          );
        }
        return OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            sizedBoxHeightMultiplier[0] = 1;
            sizedBoxHeightMultiplier[1] = 1;
            sizedBoxHeightMultiplier[2] = 1;
            imageMultiplier[0] = 1;
            imageMultiplier[1] = 1;
            borderRadiusMultiplier = 1;
            fontSizeMultiplier[0] = 1;
            fontSizeMultiplier[1] = 1;
            fontSizeMultiplier[2] = 1;
            fontSizeMultiplier[3] = 1;
          } else {
            sizedBoxHeightMultiplier[0] = .1;
            sizedBoxHeightMultiplier[1] = .33;
            sizedBoxHeightMultiplier[2] = 1;
            sizedBoxHeightMultiplier[3] = 1.8;
            imageMultiplier[0] = 1.8;
            imageMultiplier[1] = 1.8;
            borderRadiusMultiplier = 1.4;
            fontSizeMultiplier[0] = 2;
            fontSizeMultiplier[1] = 2;
            fontSizeMultiplier[2] = 2;
            fontSizeMultiplier[3] = 2;
          }
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                appBar: logoAppBar(
                    height: screenHeight, imageMultiplier: imageMultiplier[0]),
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0.211 *
                            sizedBoxHeightMultiplier[0] *
                            screenHeight, // 165
                        width: MediaQuery.of(context).size.width,
                      ),
                      welcomeMessage(
                        message:
                            'See what’s happening in the world right now. ',
                        fontSize:
                            0.038 * fontSizeMultiplier[0] * screenHeight, // 30
                        weight: FontWeight.bold,
                        family: 'IBMPlexSans',
                      ),
                      SizedBox(
                        height: 0.25 *
                            sizedBoxHeightMultiplier[1] *
                            screenHeight, // 195
                        width: MediaQuery.of(context).size.width,
                      ),
                      buttons(
                          context: context,
                          height: screenHeight,
                          imageMultiplier: imageMultiplier[1],
                          borderRadiusMultiplier: borderRadiusMultiplier,
                          fontMultiplier: fontSizeMultiplier[1]),
                      SizedBox(
                        height: 0.0282 *
                            sizedBoxHeightMultiplier[2] *
                            screenHeight, // 20
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(35, 0, 50, 0),
                        child: termConditions(
                            buttons: buttonStyle(0.0141 *
                                screenHeight *
                                fontSizeMultiplier[2]), // 11
                            text: textStyle(
                                0.0141 * screenHeight * fontSizeMultiplier[2]),
                            context: context // 11
                            ),
                      ),
                      SizedBox(
                        height: 0.055 *
                            sizedBoxHeightMultiplier[3] *
                            screenHeight, // 45
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        // 35
                        child: logIn(
                          buttons: buttonStyle(0.0192 *
                              screenHeight *
                              fontSizeMultiplier[3]), // 15
                          text: textStyle(0.0192 *
                              screenHeight *
                              fontSizeMultiplier[3]), // 15
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
    });
    //);
  }
}
