import 'package:flutter/material.dart';
import 'package:minify_link/res/color/color.dart';

final themeData = ThemeData(
  primaryColor: primaryColor,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: cursorColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: elementBackgroundColor,
    isDense: true,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      primary: elementBackgroundColor,
      // minimumSize: const Size(20, 50),
      shape: const StadiumBorder(),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: elementBackgroundColor,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
    ),
  ),
);
