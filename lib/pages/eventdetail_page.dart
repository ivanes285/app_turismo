import 'package:app_turismo/models/evento.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
   const EventDetail({Key? key,  required this.evento}) : super(key: key);
  final EventosModel evento;
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
EventosModel get evento=> widget.evento;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
    child:Text(evento.title!)
    ) ,
    );
  }
}
