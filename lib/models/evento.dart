
import 'dart:convert';

EventosModel eventosModelFromJson(String str) => EventosModel.fromJson(json.decode(str));

class EventosModel {
    EventosModel({
        this.id,
        this.title,
        this.description,
        this.images,
        this.lugar,
        this.dateEvent,
        this.hour,
    });

    String? id;
    String? title;
    String? description;
    List<String>? images;
    String? lugar;
    DateTime? dateEvent;
    String? hour;

    factory EventosModel.fromJson(Map<String, dynamic> json) => EventosModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        lugar: json["lugar"],
        dateEvent: DateTime.parse(json["dateEvent"]),
        hour: json["hour"],

    );

}
