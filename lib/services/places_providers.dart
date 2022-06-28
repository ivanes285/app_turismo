import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_turismo/models/lugares.dart';
import '../utils/constants_api.dart';
import 'package:http/http.dart' as http;

class PlacesProviders extends ChangeNotifier {
  List<LugaresModel> lugares = [];

  Future<List<LugaresModel>> getPlaces(String category) async {
    String url = "";
    if (category!="All") {
      url = "${ConstansApi.baseUrlplaces}?category=$category";
    } else {
      url = ConstansApi.baseUrlplaces;
    }
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    final jsonResponse = json.decode(response.body);
    List list = jsonResponse['places'];
    lugares = list.map((e) => LugaresModel.fromJson(e)).toList();
    notifyListeners();
    return lugares;
  }
}
