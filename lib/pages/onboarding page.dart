import 'package:flutter/material.dart';
import 'package:shop_app_api/Constant/components.dart';
import 'package:shop_app_api/pages/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    //(0,0) 1
    path.lineTo(0, h);
    path.quadraticBezierTo(w * .1, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
    throw UnimplementedError();
  }
}

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardingPage> {
  var PageViewController = PageController();
  List<BoardingModel> Boarding = [
    BoardingModel('assets/OnBoardImage/onboard1.png', 'CHOOSE ITEM',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus aliquet sollicitudin nunc, quis consequat quam faucibus id. Nam rutrum elementum orci eget commodo. Aliquam ut dolor augue. Nulla volutpat erat.'),
    BoardingModel('assets/OnBoardImage/onboard2.png', 'GET DISCOUNT',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus aliquet sollicitudin nunc, quis consequat quam faucibus id. Nam rutrum elementum orci eget commodo. Aliquam ut dolor augue. Nulla volutpat erat.'),
    BoardingModel('assets/OnBoardImage/onboard3.png', 'PAY ONLINE',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus aliquet sollicitudin nunc, quis consequat quam faucibus id. Nam rutrum elementum orci eget commodo. Aliquam ut dolor augue. Nulla volutpat erat.'),
  ];
  bool isLast =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  controller: PageViewController,
                  onPageChanged: (value) {
                    if(value == Boarding.length -1){
                      setState(() {
                        isLast=true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingWidget(Boarding[index]);
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: Boarding.length,
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: PageViewController, // PageController
                    count: Boarding.length,
                    effect: WormEffect(
                        type: WormType.thin,
                        dotHeight: heightR(10, context),
                        dotWidth: widthR(10, context),
                        spacing: 5,
                        activeDotColor: Colors.tealAccent), // your preferred effect
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.tealAccent,
                    child: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      if(isLast==true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      }else{
                        PageViewController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget OnBoardingWidget(BoardingModel model) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipPath(
              child: Container(
                child: TextButton(onPressed: () {

                }, child: Text('Skip')),
                height: MediaQuery.of(context).size.height * 65 / 100,
                width: double.infinity,
                color: Colors.tealAccent.shade200,
              ),
              clipper: CustomClipPath(),
            ),
            Image(
              image: AssetImage(model.image),
              width: widthR(350, context),
              height: heightR(350, context),
            ),
            Positioned(
              top:heightR(30, context),
              left: widthR(320, context),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  }, child: Text('Skip',style: TextStyle(color: Colors.black),)),
            )
          ],
        ),
        SizedBox(
          height: heightR(10, context),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                model.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeR(30, context),
                ),
              ),
              Text(
                model.body,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeR(10, context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}