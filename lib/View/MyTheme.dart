import 'package:flutter/material.dart';

class MyTheme {
  static const String routeName = "Theme";
  static Color primarycol = Color(0xff209FA6);
  static Color backgroundLight = Colors.white;

  static ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primarycol,
      primary: primarycol,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      outline: primarycol,
    ),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: primarycol),
      titleTextStyle: TextStyle(fontSize: 28, color: primarycol),
       backgroundColor: MyTheme.backgroundLight,
       elevation: 0.2,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          fontSize: 22, color: Colors.blueGrey, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primarycol, // Set your desired background color
    ),


  );
}
