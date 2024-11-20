class ChangeFavoriteModel{
  bool? status;
  String? massage;

  ChangeFavoriteModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    massage=json["message"];
  }

}