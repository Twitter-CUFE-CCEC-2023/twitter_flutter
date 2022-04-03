import 'package:flutter/material.dart';
import '../../screens/startingpage.dart';


//Custom appBar common between multiple pages
AppBar generalAppBar(BuildContext context) {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        Navigator.popUntil(context, ModalRoute.withName(StartingPage.route));
      },
      child: const Icon(
        Icons.close,
        color: Color(0xff2798E4),
        size: 28,
      ),
    ),
    title: Image.asset('assets/images/bluetwitterlogo64.png'),
  );
}