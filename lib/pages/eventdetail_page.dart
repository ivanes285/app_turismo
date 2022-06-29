import 'package:app_turismo/models/lugares.dart';
import 'package:flutter/material.dart';

class PlaceDetail extends StatefulWidget {
   const PlaceDetail({Key? key,  required this.lugar}) : super(key: key);
  final LugaresModel lugar;
  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
LugaresModel get lugar=> widget.lugar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
    child:Text(lugar.title!)
    ) ,
    );
  }
}
