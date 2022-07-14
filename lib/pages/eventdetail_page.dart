// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers

import 'package:app_turismo/models/evento.dart';
import 'package:app_turismo/theme/style_global.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class EventDetail extends StatefulWidget {
  const EventDetail({Key? key, required this.evento}) : super(key: key);
  final EventosModel evento;
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  EventosModel get evento => widget.evento;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: ListView(
            children: [
              //CARRUSEL IMAGES
              const SizedBox(height: 5),
              Column(
                children: [
                  evento.images!.length > 1
                      ? Container(
                          child: CarouselSlider(
                          options: CarouselOptions(
                            height: 350,
                            scrollDirection: Axis.horizontal,
                            autoPlay: evento.images!.length > 1 ? true : false,
                            disableCenter: true,
                            enlargeCenterPage: true,
                          ),
                          items: evento.images!
                              .map((item) => Container(
                                    child: Center(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(item,
                                          fit: BoxFit.cover,
                                          width: 1300,
                                          height: 1200),
                                    )),
                                  ))
                              .toList(),
                        ))
                      : Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(evento.images!.first)),
                        )
                ],
              ),
              //TITULO
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10,top:15, bottom: 12),
                   padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                  color: Themas.kGreyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        evento.title!.toUpperCase(),
                        style: Themas.yellowTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: Themas.semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),

              //  DESCRIPCION Y PARROQUIA
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Themas.kBackgroundColorButton,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Descripción del Evento',
                        style: Themas.whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: Themas.semiBold,
                            color: Themas.kPrimaryColor),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.description,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ]),
                    Text(
                      evento.description!,
                      style: Themas.whiteTextStyle
                          .copyWith(fontSize: 14, fontWeight: Themas.regular),
                      textAlign: TextAlign.justify,
                    ),
                    Row(children: [
                      Text(
                        'Lugar del Evento',
                        style: Themas.whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: Themas.semiBold,
                            color: Themas.kPrimaryColor),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.place,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ]),
                    Text(
                      evento.lugar!,
                      style: Themas.whiteTextStyle
                          .copyWith(fontSize: 14, fontWeight: Themas.regular),
                      textAlign: TextAlign.justify,
                    ),

                    Row(children: [
                      Text(
                        'Fecha',
                        style: Themas.whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: Themas.semiBold,
                            color: Themas.kPrimaryColor),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.date_range,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ]),
                    Text(
                      evento.getDate,
                      style: Themas.whiteTextStyle
                          .copyWith(fontSize: 14, fontWeight: Themas.regular),
                      textAlign: TextAlign.justify,
                    ),
                    Row(children: [
                      Text(
                        'Hora',
                        style: Themas.whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: Themas.semiBold,
                            color: Themas.kPrimaryColor),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ]),
                    Text(
                      evento.hour!,
                      style: Themas.whiteTextStyle
                          .copyWith(fontSize: 14, fontWeight: Themas.regular),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

