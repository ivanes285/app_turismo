// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:app_turismo/models/categoria.dart';
import 'package:app_turismo/models/evento.dart';
import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/pages/eventdetail_page.dart';
import 'package:app_turismo/pages/placedetail_page.dart';
import 'package:app_turismo/services/conection_status_provider.dart';
import 'package:app_turismo/services/events_providers.dart';
import 'package:app_turismo/services/places_providers.dart';
import 'package:app_turismo/theme/theme.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:app_turismo/utils/warning_widget_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../services/categories_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectionStatus status = ConnectionStatus.online;
  PageController pageControllerPlaces = PageController(viewportFraction: 0.45);
  PageController pageControllerEvents = PageController(viewportFraction: 0.65);
  static var search = '';
  static var category = '';

  List<CategoriesModel> listCategory = [];
  List<LugaresModel> listLugares = [];
  List<EventosModel> listEventos = [];
  bool loadingPlaces = true;
  bool loadingEvents = true;

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

    // final eventsProviders = Provider.of<EventsProviders>(context);
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      backgroundColor: const Color(0xff1A1A1A),
      body: SafeArea(
        // * PULL TO REFRESH

        child: RefreshIndicator(
          onRefresh: () async {
            if(conexion.status.toString()==status.toString()){
            getCategory();
            getPlacesByCategory(category, '');
            getEventos();
            }
          },
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    // * NOTIFICACIÓN DE INTERNET
                    const WarningWidgetChangeNotifier(),

                    // * BUSCADOR
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => hideKeyboard(context),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: TextField(
                            onChanged: (value) {
                              search = value;
                              getPlacesByCategory(category, search);
                            },
                            decoration: InputDecoration(
                              hintText: "Busca un lugar",
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.white,
                              fillColor: Colors.white,
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
                    ),
                    const SizedBox(height: 10.0),

                    _categories(),
                    const SizedBox(height: 10.0),
                    const Text("Lugares",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    _places(),
                    const SizedBox(height: 10.0),
                    const Text("Eventos ",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    _events(),
                    const SizedBox(height: 70.0),
                   
                  ],
                ),
              ),
              Container(
                child: _footer(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    return //Insercion al lista del all
        DefaultTabController(
      length: listCategory.length,
      child: TabBar(
          onTap: (i) => {
                getPlacesByCategory(listCategory[i].name!, ''),
                category = listCategory[i].name!
              },
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

  Widget _places() {
    if (loadingPlaces) return _sckeletoPlace();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 250,
      child: listLugares.isNotEmpty
          ? PageView.builder(
              controller: pageControllerPlaces,
              physics: const BouncingScrollPhysics(),
              padEnds: false,
              itemCount: listLugares.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PlaceDetail(lugar: listLugares[index])),
                              )
                            },
                            child: FadeInImage(
                              height: 150,
                              width: double.infinity,
                              placeholder:
                                  const AssetImage('assets/no-image.png'),
                              image:
                                  NetworkImage(listLugares[index].images![0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xffFEBE02),
                          height: 70.0,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            listLugares[index].title!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : //

          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kGreyColor,
              ),
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upps..',
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      color: const Color(0xffC70039),
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 45),
                  const Center(
                      child: Text('😨 No hay registros en esta categoría',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          )))
                ],
              ),
            ),
    );
  }

  Widget _events() {
    if (loadingEvents) return _sckeletoEvents();
    return Container(
        margin: const EdgeInsets.only(top: 10),
        height: 250,
        child: listEventos.isNotEmpty
            ? PageView.builder(
                controller: pageControllerEvents,
                physics: const BouncingScrollPhysics(),
                padEnds: false,
                itemCount: listEventos.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventDetail(
                                          evento: listEventos[index])),
                                )
                              },
                              child: FadeInImage(
                                height: 150,
                                width: double.infinity,
                                placeholder:
                                    const AssetImage('assets/no-image.png'),
                                image:
                                    NetworkImage(listEventos[index].images![0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            color: const Color(0xffFEBE02),
                            height: 70.0,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              listEventos[index].title!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text('😨 No hay registrados ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ))));
  }

  Widget _footer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 68.0,
        decoration: BoxDecoration(color: kGreyColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 17.95,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icon_home.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'Home',
                    style: yellowTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_notif.png'),
                ),
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_menu.png'),
                ),
              ),
            ),
            Container(
              width: 20.0,
              height: 20.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_settings.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sckeletoPlace() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          child: Container(
            height: 230,
            child: ListView.builder(
                itemCount: 3,
                itemExtent: 150,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 100,
                    width: 100,
                  );
                }),
          )),
    );
  }

  Widget _sckeletoEvents() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          child: Container(
            height: 230,
            child: ListView.builder(
                itemCount: 3,
                itemExtent: 220,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 100,
                    width: 100,
                  );
                }),
          )),
    );
  }

  void getCategory() async {
    final categoriesProvider =
        Provider.of<CategoriesProviders>(context, listen: false);
    listCategory = await categoriesProvider.getCategories();
    listCategory.insert(0, CategoriesModel(name: 'All'));
    setState(() {});
  }

  void getPlacesByCategory(String category, String search) async {
    loadingPlaces = true;
    setState(() {});
    final placesProvider = Provider.of<PlacesProviders>(context, listen: false);
    listLugares = await placesProvider.getPlaces(category, search);
    // await Future.delayed(const Duration(milliseconds: 100));
    setState(() => loadingPlaces = false);
  }

  void getEventos() async {
    loadingEvents = true;
    setState(() {});
    final eventsProviders =
        Provider.of<EventsProviders>(context, listen: false);
    listEventos = await eventsProviders.getEvents();
    // await Future.delayed(const Duration(milliseconds: 100));
    setState(() => loadingEvents = false);
  }
}

void showTopSnackBar(BuildContext context) => Flushbar(
    duration: const Duration(seconds: 1),
    flushbarPosition: FlushbarPosition.BOTTOM)
  ..show(context); // Flushbar

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
