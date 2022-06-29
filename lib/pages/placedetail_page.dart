import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                  Container(
                      child: CarouselSlider(
                    options: CarouselOptions(
                      height: 330,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      disableCenter: false,
                      enlargeCenterPage: true,
                    ),
                    items: lugar.images!
                        // ignore: avoid_unnecessary_containers
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
                ],
              ),
              //TITULO
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: 20,
                    left: defaultMargin,
                    right: defaultMargin,
                    bottom: 30),
                decoration: BoxDecoration(color: kBackgroundColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lugar.title!.toUpperCase(),
                      style: yellowTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.near_me,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
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

