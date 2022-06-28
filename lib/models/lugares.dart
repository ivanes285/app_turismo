
import 'dart:convert';

LugaresModel lugaresModelFromJson(String str) => LugaresModel.fromJson(json.decode(str));


class LugaresModel {
    LugaresModel({
        this.id,
        this.title,
        this.description,
        this.parroquia,
        this.category,
        this.images,
        this.lat,
        this.lng,
        this.zoom,
        this.contact,
  
    });

    String? id;
    String? title;
    String? description;
    String? parroquia;
    String? category;
    List<String>? images;
    String? lat;
    String? lng;
    String? zoom;
    String? contact;
  

    factory LugaresModel.fromJson(Map<String, dynamic> json) => LugaresModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        parroquia: json["parroquia"],
        category: json["category"],
        images: List<String>.from(json["images"].map((x) => x)),
        lat: json["lat"],
        lng: json["lng"],
        zoom: json["zoom"],
        contact: json["contact"],
    );

  
}
