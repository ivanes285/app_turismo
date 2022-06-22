import 'dart:convert';
import 'package:app_turismo/models/evento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants_api.dart';

class EventsProviders extends ChangeNotifier {
List<EventosModel> eventos = [];


Future<List<EventosModel>>getEvents() async {

    Uri url = Uri.parse(ConstansApi.baseUrl);
    var response = await http.get(url);
    final jsonResponse = json.decode(response.body);
    List list = jsonResponse['events'];
    eventos = list.map((e) => EventosModel.fromJson(e)).toList();
    return eventos;
  }
}
