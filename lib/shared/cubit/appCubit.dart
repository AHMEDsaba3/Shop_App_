import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/pages/cart_page.dart';
import 'package:shop_app_api/pages/favorite_page.dart';
import 'package:shop_app_api/pages/home_page.dart';
import 'package:shop_app_api/pages/profile_page.dart';
import 'package:shop_app_api/shared/cubit/appStates.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InatialState()) {}

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Catr",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),

  ];

  List<Widget> Screens=[
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    const ProfilePage()
  ];
  void changeBottomNavBar(int index){
    currentIndex= index;
    emit(AppBottomNavState());
  }

}


