import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  static String route = '/';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
              child: Image.asset('assets/images/bluetwitterlogo64.png'),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Row(),
          backgroundColor: Colors.white,
        ),
      ),
    );
    //);
  }
}
