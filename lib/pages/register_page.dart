import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/pages/home_page.dart';
import 'package:shop_app_api/pages/login_page.dart';

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
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                        defultTextForm(
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
                            keyboardType: TextInputType.name),
                        SizedBox(
                          height: heightR(10, context),
                        ),
                        defultTextForm(
                            sufIcon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your user name';
                              }
                            },
                            context: context,
                            Controller: userNameController,
                            label: 'User Name',
                            keyboardType: TextInputType.name),
                        SizedBox(
                          height: heightR(10, context),
                        ),
                        defultTextForm(
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
                        Row(
                          children: [
                            defultTextForm(
                                widthRe: 150,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter first name';
                                  }
                                  return null;
                                },
                                context: context,
                                Controller: firstnameController,
                                label: 'first name',
                                keyboardType: TextInputType.name),
                            SizedBox(
                              width: widthR(10, context),
                            ),
                            defultTextForm(
                                widthRe: 150,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter last name';
                                  }
                                  return null;
                                },
                                context: context,
                                Controller: lastnameController,
                                label: 'last name',
                                keyboardType: TextInputType.name),
                          ],
                        ),
                        SizedBox(
                          height: heightR(10, context),
                        ),
                        defultTextForm(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          context: context,
                          sufIcon: Icons.phone,
                          Controller: phoneController,
                          label: 'phone',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: heightR(15, context),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: defaultColor),
                            child: Text(
                              'SignUp',
                              style: TextStyle(color: Colors.white),
                            )),
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
      ),
    );
  }
}
