import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubti = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              cubti.Screens[cubti.currentIndex],
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SnakeNavigationBar.color(
                  shadowColor: Colors.black,
                  elevation: 10,
                  showSelectedLabels: true,
                  padding: EdgeInsets.all(20),
                  snakeShape: SnakeShape.circle,
                  backgroundColor: defaultColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.black,
                  snakeViewColor: Colors.black,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  currentIndex: cubti.currentIndex,
                  items: cubti.bottomItems,
                  onTap: (value) {
                    cubti.changeBottomNavBar(value);
                    print(cubti.currentIndex);
                  },
                ),
              ),
            ],
          ),

        );
      },
    );
  }
}
