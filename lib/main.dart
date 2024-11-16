import 'package:flutter/material.dart';
import 'package:shop_app_api/Style/theme.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:shop_app_api/pages/onboarding%20page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool onBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  print(onBoarding);
  runApp( MyApp(onBoarding:onBoarding ,));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  const MyApp({super.key, required this.onBoarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: lightTheme,
      home:onBoarding ? LoginPage():OnBoardingPage(),

        debugShowCheckedModeBanner: false,
    );
  }
}


