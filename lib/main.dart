import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/Style/theme.dart';
import 'package:shop_app_api/layout/mian_page.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/network/remote/dio_hellper.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:shop_app_api/pages/onboarding%20page.dart';
import 'package:shop_app_api/shared/BlocObserver.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/LoginCubit/appLoginCubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHellper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  token=CacheHelper.getData(key: 'token')??'';

  if(onBoarding != null){
    if(token != ''){
      widget=MainPage();
    }else widget=LoginPage();
  }else widget=OnBoardingPage();

  runApp( MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({super.key,required this.widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AppCubit()..GetHomeData()..GetCategoriesData()..GetProfileData()..GetFavoriteData(),),
      BlocProvider(create: (context) => AppLoginCubit(),),
    ],
      child: MaterialApp(
        title: 'Shop App',
        theme: lightTheme,
        home: widget,
      
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}


