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
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final bool logActive = controller.text.isNotEmpty;
      setState(() {
        this.logActive = logActive;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                hintStyle: const TextStyle(fontSize: 18.0,color: Colors.black),
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
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(fontSize: 18.0),
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 6.0),
                suffix: IconButton(
                  icon: Icon(Icons.visibility_outlined,color: Color(0xffCED7DC),size: 25.0,),
                  onPressed: null,
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(maxHeight: 0),
                ),
              ),
              obscureText: true,
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
                              //TODO:Next Button
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
