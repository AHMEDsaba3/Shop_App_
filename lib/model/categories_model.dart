class CategoriesModel{
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=json['data'] !=null ? CategoriesData.fromJson(json['data']) : null;
  }
}

class CategoriesData {
  List<CategoriesDataData> cateData = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((element) {
        cateData.add(CategoriesDataData.fromJson(element));
      });
    }
  }
}
class CategoriesDataData{
  int? id;
  String? name;
  String? image;
  CategoriesDataData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}

