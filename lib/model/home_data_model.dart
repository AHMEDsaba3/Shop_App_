class HomeDataModel{
  bool? status;
  HomdeData? data;

  HomeDataModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=json['data'] !=null ? HomdeData.fromJson(json['data']) : null;
  }
}

class HomdeData{
  List<BannerData> banners=[];
  List<ProductData> products=[];

  HomdeData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners.add(BannerData.fromJson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products.add(ProductData.fromJson(element));
      });
    }
  }
}

class BannerData{
  int? id;
  String? image;

  BannerData.fromJson(Map<String, dynamic> json){
    id=json['id'];
    image=json['image'];
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
  bool? isFavorite;
  bool? inCart;

  ProductData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    OldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    isFavorite=json['in_favorites'];
    inCart=json['in_cart'];
  }

}