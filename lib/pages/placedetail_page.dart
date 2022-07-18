// ignore_for_file: avoid_unnecessary_containers, unnecessary_brace_in_string_interps, use_build_context_synchronously


import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/theme/style_global.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

ConnectionStatus status = ConnectionStatus.online;

class PlaceDetail extends StatefulWidget {
  final LugaresModel lugar;

  const PlaceDetail({Key? key, required this.lugar}) : super(key: key);

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  LugaresModel get lugar => widget.lugar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: ListView(
            children: [
              //CARRUSEL IMAGES
              const SizedBox(height:5),
              Column(
                children: [
                  lugar.images!.length > 1
                      ? Container(
                          child: CarouselSlider(
                          options: CarouselOptions(
                            height: 350,
                            scrollDirection: Axis.horizontal,
                            autoPlay: lugar.images!.length > 1 ? true : false,
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
                      : Container(
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
                    top: 18,
                    left: Themas.defaultMargin,
                    right: Themas.defaultMargin,
                    bottom: 20),
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
                        lugar.title!.toUpperCase(),
                        style: Themas.yellowTextStyle.copyWith(
                          fontSize: 22,
                          fontWeight: Themas.semiBold,
                        ),
                        textAlign: TextAlign.center,
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
                          onTap: () => {
                            _onShareWithResult(context, lugar.title),
                        
                          },
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
                            final disponible = await MapLauncher.isMapAvailable(
                                MapType.google);
                            if (disponible!) {
                              await MapLauncher.showMarker(
                                  mapType: MapType.google,
                                  coords: Coords(double.parse(lugar.lat!),
                                      double.parse(lugar.lng!)),
                                  title: lugar.title!.toUpperCase(),
                                  extraParams: {});
                            }
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
                    ),
                    Container(
                      child: const SizedBox(height: 10),
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
                        'Descripción del Lugar',
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
                      lugar.description!,
                      style: Themas.whiteTextStyle
                          .copyWith(fontSize: 14, fontWeight: Themas.regular),
                      textAlign: TextAlign.justify,
                    ),
                    Row(children: [
                      Text(
                        'Parroquia',
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
                      lugar.parroquia!,
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

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  await launchUrl(launchUri);
}

void _onShareWithResult(BuildContext context, lugar) async {
  final box = context.findRenderObject() as RenderBox?;
  ShareResult result;
  String titulo = lugar.toString().toUpperCase();
  result = await Share.shareWithResult(
      'Ven a $titulo, para mas información visita la página WEB https://pedromoncayoturistico.com/ o descarga nuestra aplicación móvil en la Play Store📱🤳 "Pedro Moncayo Turístico"',
      subject: 'Lugar Turístico de Pedro Moncayo',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Share result: ${result.status}"),
  ));
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

