import 'dart:convert';


List<CategoriesModel> categoriesModelFromJson(String str) => List<CategoriesModel>.from(json.decode(str).map((x) => CategoriesModel.fromJson(x)));

class CategoriesModel {
    CategoriesModel({
        this.name,
    });
    String? name;
    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        name: json["name"],
    );

}
