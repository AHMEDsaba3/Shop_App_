import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is changeCartDataSuccessState){
          if(state.cartAddDataModel!.status==false){
            defaultFlutterToast(massage: state.cartAddDataModel!.massage??'', state: ToastState.ERROR);
          }else
            defaultFlutterToast(massage: state.cartAddDataModel!.massage??'', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        if (cubit.cartDataModel != null &&
            cubit.cartDataModel!.data != null &&
            cubit.cartDataModel!.data!.itemData.isNotEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      if (state is changeCartDataLoadingState)
                        LinearProgressIndicator(
                          color: defaultColor,
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: widthR(20, context),
                                    vertical: heightR(5, context)),
                                child: Container(
                                  width: double.infinity,
                                  height: heightR(1, context),
                                  color: Colors.grey[350],
                                ),
                              ),
                              itemCount: cubit.cartDataModel!.data!.itemData.length,
                              itemBuilder: (context, index) {
                                var productData = cubit.cartDataModel!.data!
                                    .itemData[index].productData;
                                return ListTile(
                                    leading: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Container(
                                            height: heightR(80, context),
                                            width: widthR(80, context),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(
                                                    sizeR(5, context))),
                                            child: Image(
                                                image: NetworkImage(
                                                    productData?.image ?? ''))),
                                        if (productData?.discount != 0)
                                          Container(
                                              color: Colors.red,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                                child: Text(
                                                  'Discount',
                                                  style: TextStyle(
                                                      fontSize: 8, color: Colors.white),
                                                ),
                                              ))
                                      ],
                                    ),
                                    title: Text(
                                      productData?.name ?? 'no name available',
                                      maxLines: 3,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w700,
                                          fontSize: sizeR(15, context),
                                          color: Colors.black),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          productData!.price.toString(),
                                          style: TextStyle(
                                              fontSize: sizeR(12, context),
                                              color: defaultColor),
                                        ),
                                        SizedBox(
                                          width: widthR(10, context),
                                        ),
                                        if (productData.discount != 0)
                                          Text(
                                            productData.OldPrice.toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                decoration: TextDecoration.lineThrough),
                                          )
                                      ],
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        cubit.AddCartData(productData.id ?? 0);
                                      },
                                      icon: Icon(Icons.delete)
                                    ));
                              },
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                  Positioned(
                    bottom: 90,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: widthR(30, context)),
                      child: Row(
                        children: [
                          Text(
                            'total: ${cubit.cartDataModel!.data!.total.toString()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Spacer(),
                          SizedBox(
                            width: widthR(130, context),
                            height: heightR(50, context),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                                onPressed: null,
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.money_dollar,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'pay',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                  child: Text(
                    'You don\'t have items in cart',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: sizeR(20, context)),
                  )));
        }
      },
    );
  }
}
