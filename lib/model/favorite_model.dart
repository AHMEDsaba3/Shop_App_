class FavoriteModel{
  bool? status;
  String? massage;
  Data? data;
  FavoriteModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    massage=json['message'];
    data=json['data'] !=null ?Data.fromJson(json['data']):null;
  }

}
class Data{
  List<FavoriteData> favoriteData=[];
  Data.fromJson(Map<String,dynamic> json){
    if (json['data'] != null) {
      json['data'].forEach((element) {
        favoriteData.add(FavoriteData.fromJson(element));
      });
    }
  }
}
class FavoriteData{
  int? id;
  ProductData? productData;

  FavoriteData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    productData= json['product'] !=null ?ProductData.fromJson(json['product']) : null;
  }
}

class ProductData{
  int? id;
  dynamic price;
  dynamic OldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  ProductData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    OldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }

}
