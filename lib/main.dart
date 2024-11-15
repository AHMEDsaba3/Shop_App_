import 'package:flutter/material.dart';
import 'package:shop_app_api/Style/theme.dart';
import 'package:shop_app_api/pages/onboarding%20page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: lightTheme,
      home:OnBoardingPage(),

        debugShowCheckedModeBanner: false,
    );
  }
}


