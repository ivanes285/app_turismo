import 'package:app_turismo/models/evento.dart';
import 'package:app_turismo/pages/eventdetail_page.dart';
import 'package:app_turismo/utils/skeletos.dart';
import 'package:flutter/material.dart';

class Events {
  static Widget events(
      bool loadingEvents, List<EventosModel> listEventos, context) {
    PageController pageControllerEvents =
        PageController(viewportFraction: 0.65);
    if (loadingEvents) return Skeletos.sckeletoEvents();
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
                                FocusScope.of(context).unfocus(),
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
                              child: Column(
                                children: [
                                  const SizedBox(height: 2),
                                  Center(
                                      child: Text(
                                    listEventos[index].title!.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                                  Center(
                                      child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                  const SizedBox(width:18),
                                  const Icon(Icons.timer),
                                    Text(
                                      listEventos[index].hour!,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      listEventos[index].getDate,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ])),



                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text('😨 No hay eventos disponibles ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ))));
  }
}
