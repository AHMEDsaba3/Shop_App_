import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme=ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleSpacing: 20,
        elevation: 0.0,
        titleTextStyle:
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF18191a),
        selectedItemColor: Colors.cyan,
        type: BottomNavigationBarType.fixed, elevation: 20),
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor:Colors.black,
    useMaterial3: true,
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight:FontWeight.w600,
            color: Colors.black
        )
    )
);
ThemeData lightTheme=ThemeData(
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 20),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontSize: 20,
          fontWeight:FontWeight.w600,
          color: Colors.black
      )
  ),
  scaffoldBackgroundColor: Colors.white,
  colorSchemeSeed: Colors.deepPurple,
  useMaterial3: true,
);

