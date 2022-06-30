// ignore_for_file: sized_box_for_whitespace

import 'package:app_turismo/models/categoria.dart';
// import 'package:app_turismo/models/evento.dart';
import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/pages/placedetail_page.dart';
// import 'package:app_turismo/services/events_providers.dart';
import 'package:app_turismo/services/places_providers.dart';
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
  PageController pageController = PageController(viewportFraction: 0.45);
  static var search = '';
  static var category = '';
  List<CategoriesModel> listCategory = [];
  List<LugaresModel> listLugares = [];
  bool loadingPlaces = true;

  @override
  void initState() {
    super.initState();
    getCategory();
    category = 'All';
    getPlacesByCategory(category, '');
  }

  @override
  Widget build(BuildContext context) {
    // final eventsProviders = Provider.of<EventsProviders>(context);
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      backgroundColor: const Color(0xff1A1A1A),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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
                  
                        hintText: "Buscador",
                         prefixIcon: const Icon(Icons.search),
                         prefixIconColor: Colors.white,
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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

              _categories(),
              const SizedBox(height: 20.0),
              const Text("Lugares",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),

              _places(),
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
    if (loadingPlaces) return _sckeleto();

    return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 250,
        child: listLugares.isNotEmpty
            ? PageView.builder(
                controller: pageController,
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
                                      builder: (context) => PlaceDetail(
                                          lugar: listLugares[index])),
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
            : const Center(
                child: Text('😨 No hay registrados ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ))));
  }

  // Widget _events(EventsProviders eventsProviders) {
  //   // ignore: avoid_unnecessary_containers
  //   return Container(
  //       child: FutureBuilder<List<EventosModel>>(
  //           initialData: eventsProviders.eventos,
  //           future: eventsProviders.getEvents(),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               final lista = snapshot.data ?? [];
  //               log('${lista.length}');
  //               return ListView.builder(
  //                   itemCount: lista.length,
  //                   itemBuilder: (_, index) {
  //                     return Column(
  //                       children: [
  //                         Text(lista[index].title!),
  //                         Image.network(lista[index].images![0])
  //                       ],
  //                     );
  //                   });
  //             }
  //             return const CircularProgressIndicator();
  //           }));
  // }

  Widget _sckeleto() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          direction: ShimmerDirection.ltr,
          child: Container(
            height: 230,
            child: ListView.builder(
                itemCount: 3,
                itemExtent: 180,
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
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}



