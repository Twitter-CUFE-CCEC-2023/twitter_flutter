import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  static String route = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Image.asset('assets/images/bluetwitterlogo64.png'),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
