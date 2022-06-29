
import 'package:app_turismo/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants_api.dart';

class CategoriesProviders extends ChangeNotifier {
  List<CategoriesModel> categories = [];

  Future<List<CategoriesModel>> getCategories() async {
    Uri url = Uri.parse(ConstansApi.baseUrlcategories);
    var response = await http.get(url);
    categories =categoriesModelFromJson(response.body);
    notifyListeners();
    return categories;
  }
}
