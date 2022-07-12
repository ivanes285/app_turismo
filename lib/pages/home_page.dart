// ignore_for_file: empty_catches, avoid_print
import 'dart:developer';

import 'package:app_turismo/models/categoria.dart';
import 'package:app_turismo/models/evento.dart';
import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/pages/event_page.dart';
import 'package:app_turismo/pages/place_page.dart';
import 'package:app_turismo/providers/conection_status_provider.dart';
import 'package:app_turismo/providers/events_providers.dart';
import 'package:app_turismo/providers/places_providers.dart';
import 'package:app_turismo/theme/style_global.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:app_turismo/utils/warning_widget_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/categories_provider.dart';
import '../utils/skeletos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectionStatus status = ConnectionStatus.online;
  static var search = '';
  static var category = '';
  List<CategoriesModel> listCategory = [];
  List<LugaresModel> listLugares = [];
  List<EventosModel> listEventos = [];
  bool loadingPlaces = true;
  bool loadingEvents = true;
  bool loadingCategories = true;

  @override
  void initState() {
    super.initState();
    getCategory();
    category = 'All';
    getPlacesByCategory(category, '');
    getEventos();
  }

  @override
  Widget build(BuildContext context) {
    final conexion = Provider.of<ConnectionStatusChangeNotifier>(context);
    return Scaffold(
      // backgroundColor: const Color(0xff1A1A1A),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        // * PULL TO REFRESH
        child: RefreshIndicator(
            onRefresh: () async {
              if (conexion.status.toString() == status.toString()) {
                getCategory();
                getPlacesByCategory(category, '');
                getEventos();
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // * NOTIFICACIÓN CONEXION INTERNET
                      const WarningWidgetChangeNotifier(),
                      // * BUSCADOR
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: TextField(
                        style:const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              search = value;
                              getPlacesByCategory(category, search);
                            },
                            decoration: InputDecoration(
                              hintText: "Busca un lugar",
                             
                              hintStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.white,
                              prefixStyle:const TextStyle(color: Colors.white),
                              fillColor: Themas.kBackgroundColorButton,
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )),
                      ),
                      const SizedBox(height: 10.0),

                      _categories(),
                      const SizedBox(height: 10.0),
                      Row(
                        children:  [
                          const SizedBox(width: 6),
                          Text("Lugares",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Places.places(loadingPlaces, listLugares, context),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const SizedBox(width: 6),
                          Text("Eventos ",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Events.events(loadingEvents, listEventos, context),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _categories() {
    if (loadingCategories) return Skeletos.sckeletoCategories();

    return //Insercion al lista del all
        DefaultTabController(
      length: listCategory.length,
      child: TabBar(
          onTap: (i) => {
                getPlacesByCategory(listCategory[i].name!, ''),
                category = listCategory[i].name!
              },
          labelColor:Theme.of(context).primaryColorDark,
          indicatorColor: Colors.deepOrange,
          isScrollable: true,
          tabs: List<Widget>.generate(
              listCategory.length,
              (index) => Tab(
                      child: Text(
                    listCategory[index].name!,
                    style: const TextStyle(fontSize: 18.0),
                  )))),
    );
  }

  void getCategory() async {
    try {
      loadingCategories = true;
      final categoriesProvider =
          Provider.of<CategoriesProviders>(context, listen: false);
      listCategory = await categoriesProvider.getCategories();
      listCategory.insert(0, CategoriesModel(name: 'All'));
      setState(() => loadingCategories = false);
    } catch (e) {
      log('$e');
    }
  }

  void getPlacesByCategory(String category, String search) async {
    try {
      loadingPlaces = true;
      setState(() {});
      final placesProvider =
          Provider.of<PlacesProviders>(context, listen: false);
      listLugares = await placesProvider.getPlaces(category, search);
      // await Future.delayed(const Duration(milliseconds: 100));
      setState(() => loadingPlaces = false);
    } catch (e) {
      log('$e');
    }
  }

  void getEventos() async {
    try {
      loadingEvents = true;
      setState(() {});
      final eventsProviders =
          Provider.of<EventsProviders>(context, listen: false);
      listEventos = await eventsProviders.getEvents();
      // await Future.delayed(const Duration(milliseconds: 100));
      setState(() => loadingEvents = false);
    } catch (e) {
      log('$e');
    }
  }
}
