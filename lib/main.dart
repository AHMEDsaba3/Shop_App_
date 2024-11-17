import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Style/theme.dart';
import 'package:shop_app_api/layout/mian_page.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:shop_app_api/pages/onboarding%20page.dart';
import 'package:shop_app_api/shared/BlocObserver.dart';
import 'package:shop_app_api/shared/cubit/appCubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
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
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AppCubit(),),
    ],
      child: MaterialApp(
        title: 'Shop App',
        theme: lightTheme,
        home: MainPage(),
        //onBoarding ? LoginPage():OnBoardingPage(),
      
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}


