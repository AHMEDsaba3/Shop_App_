import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/model/login_model.dart';
import 'package:shop_app_api/network/remote/dio_hellper.dart';
import 'package:shop_app_api/network/remote/endpoint.dart';
import 'package:shop_app_api/shared/LoginCubit/appLoginState.dart';

class AppLoginCubit extends Cubit<Apploginstate>{
  AppLoginCubit() : super(InatialApploginState());
  static AppLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginData ;

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());
    DioHellper.PostData(url: Login, data:{
      'email':email,
      'password':password
    }).then((value) {
      loginData=LoginModel.fromJson(value.data);
      emit(AppLoginSuccessState(loginData!));
    },).catchError((e){
      print(e);
      emit(AppLoginErrorState());
    });
  }

}