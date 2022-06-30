// ignore_for_file: avoid_unnecessary_containers

import 'dart:developer';
import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

class PlaceDetail extends StatefulWidget {
  const PlaceDetail({Key? key, required this.lugar}) : super(key: key);
  final LugaresModel lugar;
  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  LugaresModel get lugar => widget.lugar;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: ListView(
            children: [
              //CARRUSEL IMAGES
              Column(
                children: [
                  lugar.images!.length >1 ?
                  Container(
                      child: CarouselSlider(
                     options: CarouselOptions(
                      height: 350,
                      scrollDirection: Axis.horizontal,
                      autoPlay: lugar.images!.length>1? true : false,
                      disableCenter: true,

                      enlargeCenterPage: true,
                    ),
                    items: lugar.images!
                       
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
                  :
                  Container(

                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(lugar.images!.first)),
                  
                  
                  )
                ],
              ),
              //TITULO
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: 30,
                    left: defaultMargin,
                    right: defaultMargin,
                    bottom: 30),
                decoration: BoxDecoration(color: kBackgroundColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        lugar.title!.toUpperCase(),
                        style: yellowTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => {_makePhoneCall(lugar.contact!)},
                          child: Column(
                            children: const [
                              Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              SizedBox(height: 8.0),
                              Center(
                                  child: Text("Contacto",
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => {log("Compartir")},
                          child: Column(
                            children: const [
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              SizedBox(height: 8.0),
                              Center(
                                  child: Text("Compartir",
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final availableMaps =
                                await MapLauncher.installedMaps;
                            await availableMaps.first.showMarker(
                              coords: Coords(double.parse(lugar.lat!),double.parse(lugar.lng!)),
                              title: lugar.title!.toUpperCase(),
                            );
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.near_me,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              SizedBox(height: 8.0),
                              Center(
                                  child: Text("Ruta",
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                color: kGreyColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: whiteTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      lugar.description!,
                      style: whiteTextStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
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

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  await launchUrl(launchUri);
}

































// class _PlaceDetailState extends State<PlaceDetail> {
// LugaresModel get lugar=> widget.lugar;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body: Center(
//     child:Text(lugar.title!)
//     ) ,
//     );
//   }
// }

