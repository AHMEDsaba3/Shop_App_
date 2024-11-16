import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailControler = TextEditingController();
    TextEditingController passwordControler = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/ShopApp.png'),
                height: heightR(200, context),
                color: Colors.white,
                width: widthR(200, context),
              ),
              Container(
                width: widthR(350, context),
                height: heightR(370, context),
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
                  padding:  EdgeInsets.all(sizeR(20, context)),
                  child: Column(
                    children: [
                      Text(
                        'Login Page',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: heightR(30, context),
                      ),
                      defultTextForm(
                          context: context,
                          Controller: emailControler,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(
                        height: heightR(10, context),
                      ),
                      defultTextForm(
                          context: context,
                          sufIcon: CupertinoIcons.eye_fill,
                          suffixPressed: () {},
                          Controller: passwordControler,
                          label: 'password',
                          keyboardType: TextInputType.visiblePassword,
                          ispassword: true),
                      SizedBox(
                        height: heightR(15, context),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print('ssssss');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: defaultColor),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have account ?'),
                          TextButton(onPressed: () {}
                              , child: Text('Register'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
