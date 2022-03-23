import 'package:flutter/material.dart';
import 'package:twitter_flutter/constants.dart';

class LoginPassword extends StatefulWidget {
  static const String ROUTE = "LoginPassword";
  const LoginPassword({Key? key}) : super(key: key);

  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool logActive = false;
  TextEditingController controller = TextEditingController();
  String? username;
  bool showPassword = false;
  Icon passwordVisibilityStyle = const Icon(Icons.visibility_outlined, color: Color(0xffCED7DC), size: 25.0);
  Icon passwordCheckSuffix = const Icon(null);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final bool logActive = controller.text.isNotEmpty;
      setState(() {
        this.logActive = logActive;
        passwordCheckSuffix = logActive ? const Icon(Icons.check_circle_outline_sharp,size:25.0,color: Color(0xFF2DB169),) : const Icon(null);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void changePasswordVisibilityIcon(bool isShown)
  {
    setState(() {
      showPassword = !showPassword;
      if(isShown)
      {
        passwordVisibilityStyle = const Icon(Icons.visibility_rounded, color: Color(0xffCED7DC), size: 25.0);
      }
      else
      {
        passwordVisibilityStyle = const Icon(Icons.visibility_rounded, color: Color(0XFF3993D0), size: 25.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    username = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
        child: Scaffold(
      appBar: generalAppBar,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your password",
              style: dispTextStyle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              enabled: false,
              showCursor: true,
              cursorHeight: 25.0,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "$username",
                hintStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 6.0),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            TextField(
              showCursor: true,
              cursorHeight: 25.0,
              textAlign: TextAlign.left,
              controller: controller,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(fontSize: 18.0),
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 6.0),
                suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: passwordVisibilityStyle,
                      onTap: () => changePasswordVisibilityIcon(showPassword),
                    ),
                    if(passwordCheckSuffix.icon != null) passwordCheckSuffix, // check that the icon suffix is not set to null
                  ],
                )
              ),
              obscureText: !showPassword,
              autocorrect: false,
              enableSuggestions: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
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
                    left: 8.0, right: 8.0, bottom: 12.0, top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        //TODO:Forget Password Button
                      },
                      child: const Text("Forget Password?"),
                      style: outlinedButtonsStyle,
                    ),
                    ElevatedButton(
                      onPressed: logActive
                          ? () {

                              //TODO:
                            }
                          : null,
                      child: const Text("Log in"),
                      style: elevatedButtonsStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

