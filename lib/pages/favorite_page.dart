import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is changeFavoriteDataSuccessState){
          if(state.changeFavoriteModel!.status==false){
            defaultFlutterToast(massage: state.changeFavoriteModel!.massage??'', state: ToastState.ERROR);
          }else
            defaultFlutterToast(massage: state.changeFavoriteModel!.massage??'', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (cubit.favoriteModel != null &&
            cubit.favoriteModel!.data != null &&
            cubit.favoriteModel!.data!.favoriteData.isNotEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
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
                  itemCount: cubit.favoriteModel!.data!.favoriteData.length,
                  itemBuilder: (context, index) {
                    var productData = cubit
                        .favoriteModel!.data!.favoriteData[index].productData;
                    return ListTile(
                        leading: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                                height: heightR(80, context),
                                width: widthR(80, context),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(sizeR(5, context))),
                                child: Image(
                                    image: NetworkImage(productData?.image ?? ''))),
                            if (productData?.discount != 0)
                              Container(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                      'Discount',
                                      style: TextStyle(fontSize: 8, color: Colors.white),
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
                                  fontSize: sizeR(12, context), color: defaultColor),
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
                            cubit.ChangeFavoriteData(productData.id ?? 0);
                          },
                          icon: cubit.favorite[productData!.id] ?? false
                              ? Icon(
                                  CupertinoIcons.heart_fill,
                                  color: defaultColor,
                                )
                              : Icon(CupertinoIcons.heart),
                        ));
                  },
                ),
              ),
            ),
          );
        } else if (state is changeFavoriteDataLoadingState) {
          return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: CircularProgressIndicator(color: defaultColor,));
        } else
          return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                  child: Text(
                'You don\'t have favorite items',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: sizeR(20, context)),
              )));
      },
    );
  }
}
