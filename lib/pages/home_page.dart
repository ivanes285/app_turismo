import 'dart:developer';

import 'package:app_turismo/models/evento.dart';
import 'package:app_turismo/services/events_providers.dart';
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
    final eventsProviders = Provider.of<EventsProviders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: Container(
            child: FutureBuilder<List<EventosModel>>(
                initialData: eventsProviders.eventos,
                future: eventsProviders.getEvents(),
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
