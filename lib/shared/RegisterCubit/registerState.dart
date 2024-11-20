import 'package:shop_app_api/model/login_model.dart';

abstract class AppRegisterstate{}

class InatialAppRegisterState extends AppRegisterstate{}

class AppRegisterLoadingState extends AppRegisterstate{}
class AppRegisterSuccessState extends AppRegisterstate{
  final LoginModel loginModel;

  AppRegisterSuccessState(this.loginModel);

}
class AppRegisterErrorState extends AppRegisterstate{}