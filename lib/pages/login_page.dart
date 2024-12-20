import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/layout/mian_page.dart';
import 'package:shop_app_api/main.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/pages/home_page.dart';
import 'package:shop_app_api/pages/register_page.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/LoginCubit/appLoginCubit.dart';
import 'package:shop_app_api/shared/LoginCubit/appLoginState.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppLoginCubit, Apploginstate>(
      builder: (context, state) {
        AppLoginCubit cubit = AppLoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/ShopApp.png',
                    height: heightR(200, context),
                    color: Colors.white,
                    width: widthR(200, context),
                  ),
                  Container(
                    width: widthR(350, context),
                    height: heightR(430, context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(sizeR(20, context)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(sizeR(20, context)),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              'Login Page',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: heightR(30, context),
                            ),
                            defaultTextForm(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              context: context,
                              Controller: emailController,
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: heightR(10, context),
                            ),
                            defaultTextForm(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              context: context,
                              sufIcon: isPasswordVisible
                                  ? CupertinoIcons.eye_slash_fill
                                  : CupertinoIcons.eye_fill,
                              suffixPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              Controller: passwordController,
                              label: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              ispassword: !isPasswordVisible,
                            ),
                            SizedBox(
                              height: heightR(15, context),
                            ),
                            state is! AppLoginLoadingState
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!
                                          .validate()) {
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password:
                                                passwordController.text);

                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: defaultColor,
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : CircularProgressIndicator(color: defaultColor,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text('Register'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AppLoginSuccessState) {
          if (state.loginModel.status == true) {
            defaultFlutterToast(massage:state.loginModel.message??'',state: ToastState.SUCCESS );
            CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              );
            },);
            token = state.loginModel.data!.token!;
            AppCubit.get(context).GetProfileData();
            AppCubit.get(context).GetCartData();
            AppCubit.get(context).GetFavoriteData();
            AppCubit.get(context).GetHomeData();
            AppCubit.get(context).GetCategoriesData();
          } else {
            defaultFlutterToast(massage:state.loginModel.message??'',state: ToastState.ERROR );
          }
        }
      },
    );
  }
}
