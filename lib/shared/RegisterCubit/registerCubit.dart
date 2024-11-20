import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/model/login_model.dart';
import 'package:shop_app_api/network/remote/dio_hellper.dart';
import 'package:shop_app_api/network/remote/endpoint.dart';
import 'package:shop_app_api/shared/RegisterCubit/registerState.dart';


class AppRegisterCubit extends Cubit<AppRegisterstate>{
  AppRegisterCubit() : super(InatialAppRegisterState());
  static AppRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginData ;

  void userRegister({required String name,required String phone,required String email, required String password}) {
    emit(AppRegisterLoadingState());
    DioHellper.PostData(url: Register, data:{
      'name':name,
      'phone':phone,
      'email':email,
      'password':password
    }).then((value) {
      loginData=LoginModel.fromJson(value.data);
      emit(AppRegisterSuccessState(loginData!));
    },).catchError((e){
      print(e);
      emit(AppRegisterErrorState());
    });
  }
}