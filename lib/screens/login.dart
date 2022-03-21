import 'package:flutter/material.dart';
import 'package:twitter_flutter/constants.dart';

class LoginUsername extends StatefulWidget {
  const LoginUsername({Key? key}) : super(key: key);
  static const String route = "LoginUsername";

  @override
  State<LoginUsername> createState() => _LoginUsernameState();
}

class _LoginUsernameState extends State<LoginUsername> {
  bool nextActive = false;
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    bool nextActive = controller.text.isNotEmpty;
    setState(() {
      nextActive = this.nextActive;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: generalAppBar,
        body: Column(
          children: [
           const Padding(
              padding: EdgeInsets.only(left:20.0,right: 30,top:30.0,bottom: 10.0),
              child: Text(
                "To get started, first enter your phone, email address or @username",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              showCursor: true,
              textAlign: TextAlign.left,
              controller: controller,
              decoration:const InputDecoration(
                labelText: "Phone, email address, or username",
                contentPadding: EdgeInsets.all(0.0),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
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
                      onPressed: nextActive? () {
                        //TODO:Next Button
                      }:null,
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
    );
  }
}
