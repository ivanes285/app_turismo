import 'dart:developer';

import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/services/places_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    final placesProviders = Provider.of<PlacesProviders>(context);

    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        // ignore: avoid_unnecessary_containers
        body: Container(
      
            child: FutureBuilder<List<LugaresModel>>(
                initialData: placesProviders.lugares,
                future:placesProviders.getPlaces(''),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final lista = snapshot.data ?? [];
                    log('${lista.length}');
                    return ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (_, index) {
                          return  Column(
                            children: [
                              Text(lista[index].title!),
                              Image.network(lista[index].images![0])
                            ],
                          );
                        });
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
