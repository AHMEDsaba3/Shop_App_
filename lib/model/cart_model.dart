class CartDataModel {
  bool? status;
  CartData? data;

  CartDataModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=json['data'] !=null ?CartData.fromJson(json['data']):null;
  }

}

class CartData {
  List<ItemData> itemData=[];
  dynamic subTotal;
  dynamic total;
  CartData.fromJson(Map<String,dynamic> json){
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((element) {
        itemData.add(ItemData.fromJson(element));
      });
    }
    subTotal=json['sub_total'];
    total=json['total'];
  }
}
class ItemData{
  int? id;
  int? quantity;
  ProductData? productData;
  ItemData.fromJson(Map<String, dynamic> json){
    id=json['id'];
    quantity=json['quantity'];
    productData=json['product'] !=null ?ProductData.fromJson(json['product']):null;
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