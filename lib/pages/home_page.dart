import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/model/categories_model.dart';
import 'package:shop_app_api/model/home_data_model.dart';
import 'package:shop_app_api/pages/product_details_page.dart';
import 'package:shop_app_api/shared/HomeCubit/appCubit.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        var model = cubit.homeDataModel;
        var modelCate = cubit.categoriesModel;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: getBody(
                      context, model ?? null, modelCate ?? null, cubit))),
        );
      },
    );
  }

  Widget getBody(context, HomeDataModel? model, CategoriesModel? modelCate, AppCubit cubit) {
    List<Widget> advList = [];

    if (model != null && model.data != null) {
      advList = model.data!.banners
          .map((banner) => Image.network(banner.image ?? '', fit: BoxFit.cover))
          .toList();
    }
    // if (model != null && model.data != null && model.data!.banners != null) {
    //   advList = model.data!.banners.map((banner) {
    //     return adv_body(
    //       image: banner.image ?? '',
    //       context: context,
    //     );
    //   }).toList();
    // }
    if (model != null && model.data != null && advList.isNotEmpty && modelCate != null && modelCate.data != null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: heightR(50, context),
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                      text: 'Welcome,\n',
                      style: TextStyle(
                        fontSize: sizeR(35, context),
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                            text: 'Our Shop App',
                            style: TextStyle(
                              fontSize: sizeR(30, context),
                              color: Colors.grey,
                            ))
                      ]),
                ),
              ),
              SizedBox(
                height: heightR(30, context),
              ),
              Container(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SearchBar(
                        constraints:
                            BoxConstraints(maxWidth: widthR(275, context)),
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        hintText: 'Search...',
                        leading: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              size: sizeR(30, context),
                            )),
                      ),
                    ],
                  )),
              SizedBox(
                height: heightR(30, context),
              ),
              //////////advertisements /////////////
              // if(advList.isNotEmpty)
              Container(
                height: heightR(160, context),
                width: double.maxFinite,
                child: CarouselSlider(
                    items: advList,
                    // items: [
                    //   adv_body('assets/adv/adv1.png', 50, context),
                    //   adv_body('assets/adv/adv2.png', 50, context),
                    // ],
                    options: CarouselOptions(
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal)),
              ),
              // else
              //   Center(
              //     child: LinearProgressIndicator()),
              SizedBox(
                height: heightR(20, context),
              ),

              //////////Categories /////////////

              Text(
                'Categories',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeR(20, context),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: heightR(10, context),
              ),
              // if(modelCate != null &&
              //     modelCate!.data != null &&
              //     modelCate!.data!.cateData != null)
              Container(
                height: heightR(45, context),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => CategoryWidget(
                        title: modelCate.data!.cateData[index].name ?? ''),
                    separatorBuilder: (context, index) => SizedBox(
                          width: widthR(10, context),
                        ),
                    itemCount: modelCate!.data!.cateData.length),
              ),
              // else  LinearProgressIndicator(),

              SizedBox(
                height: heightR(10, context),
              ),

              //////////Products /////////////

              // if (model != null &&
              //     model!.data != null &&
              //     model!.data!.products != null)
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.37,
                children: List.generate(
                  model.data!.products.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(
                          id: model.data!.products[index].id??0,
                          title: model.data!.products[index].name??'',
                          description: model.data!.products[index].description??'',
                          discount: model.data!.products[index].discount??'',
                          OldPrice: model.data!.products[index].OldPrice??'',
                          price: model.data!.products[index].price??'',
                          image: model.data!.products[index].image??'',
                        ),));
                      },
                      child: BuildproductView(context,
                          title: model.data!.products[index].name ?? '',
                          price: model.data!.products[index].price ?? "",
                          oldPrice: model.data!.products[index].OldPrice ?? "",
                          image: model.data!.products[index].image ?? "",
                          discount: model.data!.products[index].discount,
                          model: model,
                          cubit: cubit,
                          index: index),
                    );
                  },
                ),
              )
              // else
              //   Center(
              //     child: CircularProgressIndicator(),
              //   ),
            ],
          ),
        ),
      );
    } else {
      return Center(
          child: LinearProgressIndicator(
        color: defaultColor,
      ));
    }
  }

  Widget adv_body({required String image, required int saleNo, context}) {
    return Container(
      width: widthR(340, context),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizeR(20, context)),
        color: defaultColor,
      ),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              child: Image.asset(
                image,
                height: heightR(150, context),
                width: widthR(150, context),
              )),
          Padding(
            padding: EdgeInsets.all(sizeR(15, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${saleNo}% Off',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: sizeR(25, context)),
                ),
                Text(
                  'On everything today',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: sizeR(16, context)),
                ),
                SizedBox(
                  height: heightR(10, context),
                ),
                Text(
                  'With code:FSCRETION',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: sizeR(11, context)),
                ),
                SizedBox(
                  height: heightR(14, context),
                ),
                SizedBox(
                  width: widthR(70, context),
                  height: heightR(25, context),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(sizeR(30, context)))),
                    onPressed: () {},
                    child: Text(
                      'Get Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeR(10, context),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildproductView(context,
      {required String image,
      required String title,
      required dynamic price,
      required dynamic oldPrice,
      required dynamic discount,
      required HomeDataModel model,
      required AppCubit cubit,
      required int index}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(sizeR(10, context))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(image),
                height: heightR(150, context),
                width: double.infinity,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      cubit.ChangeFavoriteData(model.data!.products[index].id??0);
                      // print(model.data!.products[index].id);
                      // print(cubit.favorite[model.data!.products[index].id]);
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    icon: cubit.favorite[model.data!.products[index].id]??false
                        ? Icon(
                      CupertinoIcons.heart_fill,
                      color: defaultColor,
                    )
                        :Icon(CupertinoIcons.heart) ),
              ),
              if (discount != 0)
                Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'Discount',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: sizeR(14, context), height: 1.4),
                ),
                Row(
                  children: [
                    Text(
                      price.toString(),
                      style: TextStyle(
                          fontSize: sizeR(12, context), color: defaultColor),
                    ),
                    SizedBox(
                      width: widthR(10, context),
                    ),
                    if (discount != 0)
                      Text(
                        oldPrice.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CategoryWidget({required String title}) {
    return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ));
  }
}
