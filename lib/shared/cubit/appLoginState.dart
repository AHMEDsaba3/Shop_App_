import 'package:shop_app_api/model/login_model.dart';

abstract class Apploginstate{}

class InatialApploginState extends Apploginstate{}

class AppLoginLoadingState extends Apploginstate{}
class AppLoginSuccessState extends Apploginstate{
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);

}
class AppLoginErrorState extends Apploginstate{}