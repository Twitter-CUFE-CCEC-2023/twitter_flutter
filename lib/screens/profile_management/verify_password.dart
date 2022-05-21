import 'package:flutter/material.dart';
import 'package:twitter_flutter/widgets/authentication/constants.dart';
import 'account_information.dart';
import 'change_phone.dart';

class VerifyPassword extends StatefulWidget {
  static const String route = "/VerifyPassword";
  const VerifyPassword({Key? key}) : super(key: key);

  @override
  verifypassword createState() => verifypassword();
}

class verifypassword extends State<VerifyPassword> {
  bool nextActive = false;
  TextEditingController _passwordfield = TextEditingController();
  bool showPassword = false;
  Icon passwordVisibilityStyle = const Icon(Icons.visibility_outlined,
      color: Color(0xffCED7DC), size: 25.0);
  Icon passwordCheckSuffix = const Icon(null);
  Widget? bottomSheet = null;

  @override
  void initState() {
    super.initState();
    _passwordfield.addListener(() {
      final bool nextActive = _passwordfield.text.isNotEmpty;
      setState(() {
        this.nextActive = nextActive;
        passwordCheckSuffix = nextActive
            ? const Icon(
          Icons.check_circle_outline_sharp,
          size: 25.0,
          color: Color(0xFF2DB169),
        )
            : const Icon(null);
      });
    });
  }

  @override
  void dispose() {
    _passwordfield.dispose();
    super.dispose();
  }

  void changePasswordVisibilityIcon(bool isShown) {
    setState(() {
      showPassword = !showPassword;
      if (isShown) {
        passwordVisibilityStyle = const Icon(Icons.visibility_rounded,
            color: Color(0xffCED7DC), size: 25.0);
      } else {
        passwordVisibilityStyle = const Icon(Icons.visibility_rounded,
            color: Color(0XFF3993D0), size: 25.0);
      }
    });
  }
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
        return  Colors.white;
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final List<double> imageMultiplier = [1, 1];
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
                appBar: logoAppBar(height: screenHeight, imageMultiplier: imageMultiplier[0]),
                bottomSheet: bottomSheet,
                body: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Verify your password",
                        style: dispTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text("Re-enter your Twitter password to continue",style: TextStyle(
                        fontSize: 0.0212 * fontSizeMultiplier[0] *
                            screenHeight,color: Colors.black54)),

                      const SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        showCursor: true,
                        cursorHeight: 25.0,
                        textAlign: TextAlign.left,
                        controller: _passwordfield,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 18.0),
                            isDense: true,
                            contentPadding:
                            const EdgeInsets.only(bottom: 6.0),
                            suffixIconConstraints: const BoxConstraints(
                                minWidth: 0, minHeight: 0),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: passwordVisibilityStyle,
                                  onTap: () =>
                                      changePasswordVisibilityIcon(
                                          showPassword),
                                ),
                                if (passwordCheckSuffix.icon != null)
                                  passwordCheckSuffix,
                                // check that the icon suffix is not set to null
                              ],
                            )),
                        obscureText: !showPassword,
                        autocorrect: false,
                        enableSuggestions: false,
                      ),
                    ],
                  ),
                ),

                bottomNavigationBar: Transform.translate(
                  offset: Offset(
                      0.0, -1 * MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom),
                  child: BottomAppBar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          color: Color(0xffD9DCDD),
                          thickness: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 12.0,
                              top: 4.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Account.route);
                                },
                                child: Text("Cancel", style: TextStyle(
                                  fontSize: 0.0232 * fontSizeMultiplier[0] *
                                      screenHeight,),),
                              ),
                              ElevatedButton(
                                onPressed: nextActive
                                    ? () {
                                  Navigator.pushNamed(
                                      context, ChangePhone.route);

                                }
                                    : null,
                                child: const Text("Next"),
                                style: elevatedButtonsStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ));
    }
    );
  }
}
