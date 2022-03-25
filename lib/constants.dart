import 'package:flutter/material.dart';

//Variation of the light theme to suite the general them of Twitter application
ThemeData generalTheme = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarTheme: const BottomAppBarTheme(
      elevation: 0,
      color: Colors.white,
    ));

//Custom appBar common between multiple pages
AppBar generalAppBar = AppBar(
  leading: const Icon(
    Icons.close,
    color: Color(0xff2798E4),
    size: 28,
  ),
  title: Image.asset('assets/images/bluetwitterlogo64.png'),
);

//outlined authentication Button Style
ButtonStyle outlinedButtonsStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  overlayColor: MaterialStateProperty.all<Color>(Colors.black26),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  ),
  textStyle: MaterialStateProperty.all<TextStyle>(
    const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),
  ),
);

//Elevated Authentication Button Style
ButtonStyle elevatedButtonsStyle = ButtonStyle(
  backgroundColor:
      MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return const Color(0xff666666);
    } else {
      return Colors.black;
    }
  }),

  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states){
        if(states.contains(MaterialState.disabled)){
         return const Color(0xffc2c2c2);
        }else
          {
            return Colors.white;
          }
      }),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  ),
  textStyle: MaterialStateProperty.all<TextStyle>(
    const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),
  ),
);

//Authentication Display Text Style

const TextStyle dispTextStyle = TextStyle(
  fontSize: 32,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
