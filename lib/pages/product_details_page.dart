import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/model/home_data_model.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';


class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage(
      {super.key,
      required this.title,
      required this.description,
      required this.discount,
      required this.OldPrice,
      required this.image,
      required this.price,
      required this.id
      });

  final int id;
  final String title;
  final String description;
  final String image;
  final dynamic discount;
  final dynamic price;
  final dynamic OldPrice;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

int index = 1;

class _ProductDetailsPageState extends State<ProductDetailsPage> {
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
        if(state is changeCartDataSuccessState){
          if(state.cartAddDataModel!.status==false){
            defaultFlutterToast(massage: state.cartAddDataModel!.massage??'', state: ToastState.ERROR);
          }else
            defaultFlutterToast(massage: state.cartAddDataModel!.massage??'', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        var model = cubit.homeDataModel;
        if(model != null) {
          return Scaffold(
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 53, left: 25, right: 25),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(CupertinoIcons.back,color: Colors.white,)),
                        backgroundColor: Colors.black,
                      ),
                      Spacer(),
                      CircleAvatar(
                        child: Icon(
                          CupertinoIcons.bag,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white70,
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.maxFinite,
                    height: 300,
                    child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: NetworkImage(
                                  widget.image,
                                ),
                                errorBuilder: (context, error, stackTrace) {
                                  return CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                },
                                width: widthR(350, context),
                                height: heightR(350, context),
                                fit: BoxFit.cover,
                              ),
                                if(widget.discount!=0)
                                Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(
                                        'Discount',
                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                    ))
                            ],
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
                  child: Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                cubit.ChangeFavoriteData(widget.id);
                              },
                              icon: cubit.favorite[widget.id]??false
                                  ? Icon(
                                CupertinoIcons.heart_fill,
                                color: defaultColor,
                              )
                                  :Icon(CupertinoIcons.heart)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Description',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Text(
                                              widget.description,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              child: Text('Close',style: TextStyle(color: defaultColor),),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    widget.description,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ), //des
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                widget.price.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: widthR(8, context),),
                              if(widget.discount !=0)
                                Text(
                                  widget.OldPrice.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              Spacer(),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStatePropertyAll(Colors.black)),
                                    onPressed: () {
                                      cubit.AddCartData(widget.id);
                                      print(token);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.bag,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Add to cart',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
        } else return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
