import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/Constant/constans.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: getBody(context))),
    );
  }

  Widget getBody(context) {
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
            Container(
              height: heightR(160, context),
              width: double.maxFinite,
              child: CarouselSlider(
                  items: [
                    adv_body('assets/adv/adv1.png', 50, context),
                    adv_body('assets/adv/adv2.png', 50, context),
                  ],
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
            SizedBox(
              height: heightR(20, context),
            ),
            Text(
              'Categories',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: sizeR(20, context),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: heightR(10, context),
            ),
            Container(
              height: heightR(45, context),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => CategoryWidget(),
                  separatorBuilder: (context, index) => SizedBox(
                        width: widthR(10, context),
                      ),
                  itemCount: 10),
            ),

            SizedBox(
              height: heightR(10, context),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.2,
              children: List.generate(
                10,
                (index) {
                  return BuildproductView(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget adv_body(String image, int saleNo, context) {
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
                          fontFamily: 'Poppins',
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

  Widget BuildproductView(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/ShopApp.png',
          height: heightR(150, context),
          color: Colors.red,
          width: double.infinity,
        ),
        Text(
          'Title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        Row(
          children: [
            Text(
              'price',
              style: TextStyle(fontSize: 12, color: defaultColor),
            ),
            SizedBox(
              width: widthR(10, context),
            ),
            Text(
              'descount',
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.lineThrough),
            )
          ],
        ),
      ],
    );
  }

  Widget CategoryWidget() {
    return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
        child: Text(
          'title',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ));
  }
}
