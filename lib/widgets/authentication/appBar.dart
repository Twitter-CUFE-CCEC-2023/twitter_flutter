import 'package:flutter/material.dart';
import '../../screens/starting_page.dart';


//Custom appBar common between multiple pages
AppBar generalAppBar(BuildContext context,double imageMultiplier) {
  double height = MediaQuery.of(context).size.height;
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
    title: Image.asset('assets/images/bluetwitterlogo64.png',
      width: 0.083 * imageMultiplier * height, // 65
      height: 0.083 * imageMultiplier * height,  // 65
    ),
  );
}

