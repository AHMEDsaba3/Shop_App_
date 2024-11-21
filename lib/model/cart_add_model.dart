class CartAddDataModel{
  bool? status;
  String? massage;

  CartAddDataModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    massage=json["message"];
  }

}