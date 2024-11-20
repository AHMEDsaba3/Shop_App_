import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_api/Constant/constans.dart';
import 'package:shop_app_api/model/Profile_model.dart';
import 'package:shop_app_api/model/categories_model.dart';
import 'package:shop_app_api/model/change_favorite_model.dart';
import 'package:shop_app_api/model/favorite_model.dart';
import 'package:shop_app_api/model/home_data_model.dart';
import 'package:shop_app_api/network/remote/dio_hellper.dart';
import 'package:shop_app_api/network/remote/endpoint.dart';
import 'package:shop_app_api/pages/cart_page.dart';
import 'package:shop_app_api/pages/favorite_page.dart';
import 'package:shop_app_api/pages/home_page.dart';
import 'package:shop_app_api/pages/profile_page.dart';
import 'package:shop_app_api/shared/HomeCubit/appStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InatialState()) {}

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Catr",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];
  List<Widget> Screens = [
    const HomePage(),
    const FavoritePage(),
    const CartPage(),
    const ProfilePage()
  ];
  Map<int,bool> favorite={};

  HomeDataModel? homeDataModel;
  CategoriesModel? categoriesModel;
  ProfileModel? profileModel;
  ChangeFavoriteModel? changeFavoriteModel;
  FavoriteModel? favoriteModel;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  void GetHomeData(){
    emit(HomeDataLoadingState());
    DioHellper.GetData(url: Home,token: token).then((value) {
      homeDataModel=HomeDataModel.fromJson(value.data);
      homeDataModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id!:element.isFavorite!,
        });
      },);
      print("=======================");
      print(favorite.toString());
      emit(HomeDataSuccessState());
    },).catchError((e){
      print(e.toString());
      emit(HomeDataErrorState());
    });

  }

  void GetCategoriesData(){
    emit(categoriesDataLoadingState());
    DioHellper.GetData(url: Categories).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(categoriesDataSuccessState());
    },).catchError((e){
      print(e.toString());
      emit(categoriesDataErrorState());
    });

  }

  void GetProfileData(){
    emit(profileDataLoadingState());
    DioHellper.GetData(url: Profile,token: token).then((value) {
      profileModel=ProfileModel.fromJson(value.data);
      print(value.data.toString());
      emit(profileDataSuccessState());
    },).catchError((e){
      print(e.toString());
      emit(profileDataErrorState());
    });

  }

  void ChangeFavoriteData(int id){
    favorite[id]= !favorite[id]!;
    emit(changeFavoriteDataLoadingState());
    DioHellper.PostData(url: Favorites, data: {
      'product_id':id,
    },token: token).then((value) {
      changeFavoriteModel=ChangeFavoriteModel.fromJson(value.data);
      // print(changeFavoriteModel?.status);
      // print(favorite.toString());
      // print(changeFavoriteModel?.massage);
      if (changeFavoriteModel?.status==false) {
        favorite[id] = !favorite[id]!;
      }
      GetFavoriteData();
      emit(changeFavoriteDataSuccessState(changeFavoriteModel));
    },).catchError((e){
      favorite[id]= !favorite[id]!;
      print(e.toString());
      emit(changeFavoriteDataErrorState());
    });
    
  }

  void GetFavoriteData(){
    emit(getFavoriteDataLoadingState());
    DioHellper.GetData(url: Favorites,token: token).then((value) {
      favoriteModel=FavoriteModel.fromJson(value.data);
      print("=============================+++++++++++++++++++++");
      print(favoriteModel!.data!.favoriteData[0].id.toString());
      print(favoriteModel!.data!.favoriteData[0].productData!.id.toString());
      emit(HomeDataSuccessState());
    },).catchError((e){
      print(e.toString());
      emit(HomeDataErrorState());
    });

  }



}
