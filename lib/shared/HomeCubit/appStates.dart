import 'package:shop_app_api/model/change_favorite_model.dart';

abstract class AppStates{}

class InatialState extends AppStates{}
class AppBottomNavState extends AppStates{}

class HomeDataLoadingState extends AppStates{}
class HomeDataSuccessState extends AppStates{}
class HomeDataErrorState extends AppStates{}

class categoriesDataLoadingState extends AppStates{}
class categoriesDataSuccessState extends AppStates{}
class categoriesDataErrorState extends AppStates{}

class profileDataLoadingState extends AppStates{}
class profileDataSuccessState extends AppStates{}
class profileDataErrorState extends AppStates{}

class changeFavoriteDataLoadingState extends AppStates{}
class changeFavoriteDataSuccessState extends AppStates{
  final ChangeFavoriteModel? changeFavoriteModel;
  changeFavoriteDataSuccessState(this.changeFavoriteModel);
}
class changeFavoriteDataErrorState extends AppStates{}

class getFavoriteDataLoadingState extends AppStates{}
class getFavoriteDataSuccessState extends AppStates{}
class getFavoriteDataErrorState extends AppStates{}