// To parse this JSON data, do
//
//     final comprador = compradorFromJson(jsonString);

import 'dart:convert';

Comprador compradorFromJson(String str) => Comprador.fromJson(json.decode(str));

String compradorToJson(Comprador data) => json.encode(data.toJson());

class Comprador {
  Comprador({
    this.dir2,
    this.long,
    this.lat,
    this.ciudad,
    this.nombre,
    this.dir1,
    this.phone,
  });

  String? dir2;
  String? long;
  String? lat;
  String? ciudad;
  String? nombre;
  String? dir1;
  String? phone;

  factory Comprador.fromJson(Map<String, dynamic> json) => Comprador(
        dir2: json["dir_2"],
        long: json["long"],
        lat: json["lat"],
        ciudad: json["ciudad"],
        nombre: json["nombre"],
        dir1: json["dir_1"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "dir_2": dir2,
        "long": long,
        "lat": lat,
        "ciudad": ciudad,
        "nombre": nombre,
        "dir_1": dir1,
        "phone": phone,
      };
}
