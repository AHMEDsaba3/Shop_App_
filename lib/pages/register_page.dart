import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/layout/mian_page.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/pages/home_page.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/RegisterCubit/registerCubit.dart';
import 'package:shop_app_api/shared/RegisterCubit/registerState.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit,AppRegisterstate>(
        listener: (context, state) {
          if (state is AppRegisterSuccessState) {
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
        builder: (context, state) {
          AppRegisterCubit cubit=AppRegisterCubit.get(context);
          return Scaffold(
            
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/ShopApp.png'),
                          height: heightR(200, context),
                          color: Colors.white,
                          width: widthR(200, context),
                        ),
                        Container(
                          width: widthR(350, context),
                          height: heightR(742, context),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                  
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(sizeR(20, context)),
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(sizeR(20, context)),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Text(
                                    'SignUp Page',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(
                                    height: heightR(30, context),
                                  ),
                                  defaultTextForm(
                                      sufIcon: Icons.person,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                      context: context,
                                      Controller: nameController,
                                      label: 'name',
                                      keyboardType: TextInputType.name),
                                  SizedBox(
                                    height: heightR(10, context),
                                  ),
                                  defaultTextForm(
                                      sufIcon: Icons.phone_android,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your phone';
                                        }
                                      },
                                      context: context,
                                      Controller: phoneController,
                                      label: 'Phone',
                                      keyboardType: TextInputType.phone),
                                  SizedBox(
                                    height: heightR(10, context),
                                  ),
                                  defaultTextForm(
                                      sufIcon: Icons.email,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                      context: context,
                                      Controller: emailController,
                                      label: 'Email',
                                      keyboardType: TextInputType.emailAddress),
                                  SizedBox(
                                    height: heightR(10, context),
                                  ),
                                  defaultTextForm(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
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
                                    label: 'password',
                                    keyboardType: TextInputType.visiblePassword,
                                    ispassword: !isPasswordVisible,),
                                  SizedBox(
                                    height: heightR(15, context),
                                  ),
                                  SizedBox(
                                    height: heightR(15, context),
                                  ),
                                  state is! AppRegisterLoadingState ?
                                  ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!
                                            .validate()) {
                                          cubit.userRegister(
                                            name: nameController.text,
                                              phone: phoneController.text,
                                              email: emailController.text,
                                              password:
                                              passwordController.text);
                  
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: defaultColor),
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(color: Colors.white),
                                      )) : CircularProgressIndicator(color: defaultColor,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Have an account ?'),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LoginPage(),
                                                ));
                                          },
                                          child: Text('Login'))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: heightR(30, context),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SafeArea(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(CupertinoIcons.back)),),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
