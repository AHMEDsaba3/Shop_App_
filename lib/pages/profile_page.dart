import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:shop_app_api/shared/LoginCubit/appLoginCubit.dart';
import 'package:shop_app_api/shared/LoginCubit/appLoginState.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppLoginCubit, Apploginstate>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: ElevatedButton(
                onPressed: () {
                  CacheHelper.removeData(key: 'token').then(
                        (value) {
                      if (value){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                        defualtFlutterToast(massage: 'Logout done successfully', state: ToastState.SUCCESS);
                      }
                    },
                  );
                },
                child: Text('Sign out')),
          ),
        );
      },
    );
  }
}
