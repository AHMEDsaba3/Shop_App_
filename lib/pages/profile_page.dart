import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/model/Profile_model.dart';
import 'package:shop_app_api/network/local/cache_helper.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubti = AppCubit.get(context);
        var model = cubti.profileModel;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: getBody(context,model??null))
        );
      },
    );
  }
  Widget getBody(context,ProfileModel? model) {
    if(model !=null&&model.data != null) {
      return Padding(
      padding:  EdgeInsets.all(sizeR(25, context)),
      child: Container(
        child: Column(
          children: [
            Container(
              height: heightR(70, context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeR(10, context)),
                  boxShadow: [
                    BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)
                  ],
                  color: Colors.white),
              child: Padding(
                padding:  EdgeInsets.all(sizeR(8, context)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: sizeR(30, context),
                      backgroundColor: Colors.grey[350],
                      child: Image(image: NetworkImage(model!.data!.image??''),fit: BoxFit.cover,height: heightR(54, context),),
                    ),
                    SizedBox(
                      width: widthR(10, context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model!.data!.name??'',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: sizeR(18, context),
                              color: Colors.black),
                        ),
                        Text(
                          model!.data!.email??'',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: sizeR(15, context),
                              color: Colors.grey[400]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: heightR(30, context),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(sizeR(20, context))),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                        height: heightR(35, context),
                        width: widthR(35, context),
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(sizeR(5, context))),
                        child: Icon(Icons.person)),
                    title: Text(
                      'Edit Person Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: sizeR(15, context),
                          color: Colors.black),
                    ),
                    trailing: Icon(CupertinoIcons.right_chevron),
                  ),
                  ListTile(
                    leading: Container(
                        height: heightR(35, context),
                        width: widthR(35, context),
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(sizeR(5, context))),
                        child: Icon(Icons.shopping_bag)),
                    title: Text(
                      'My order',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: sizeR(15, context),
                          color: Colors.black),
                    ),
                    trailing: Icon(CupertinoIcons.right_chevron),
                  ),
                  ListTile(
                    leading: Container(
                        height: heightR(35, context),
                        width: widthR(35, context),
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(sizeR(5, context))),
                        child: Icon(Icons.local_shipping)),
                    title: Text(
                      'Shipping Address',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: sizeR(15, context),
                          color: Colors.black),
                    ),
                    trailing: Icon(CupertinoIcons.right_chevron),
                  ),
                  ListTile(
                    leading: Container(
                        height: heightR(35, context),
                        width: widthR(35, context),
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(sizeR(5, context))),
                        child: Icon(Icons.credit_card)),
                    title: Text(
                      'My Card',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: sizeR(15, context),
                          color: Colors.black),
                    ),
                    trailing: Icon(CupertinoIcons.right_chevron),
                  ),
                  ListTile(
                    leading: Container(
                        height: heightR(35, context),
                        width: widthR(35, context),
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(sizeR(5, context))),
                        child: Icon(Icons.settings)),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: sizeR(15, context),
                          color: Colors.black),
                    ),
                    trailing: Icon(CupertinoIcons.right_chevron),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: defaultColor),
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
                              defaultFlutterToast(massage: 'Logout done successfully', state: ToastState.SUCCESS);
                            }
                          },
                        );
                      },
                      child: Text('Sign out',style: TextStyle(color: Colors.white),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
    } else {
      return SafeArea(child: LinearProgressIndicator(color: defaultColor,));
    }
  }
}
