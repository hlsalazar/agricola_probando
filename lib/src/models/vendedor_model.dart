// To parse this JSON data, do
//
//     final vendedor = vendedorFromJson(jsonString);

import 'dart:convert';

Vendedor vendedorFromJson(String str) => Vendedor.fromJson(json.decode(str));

String vendedorToJson(Vendedor data) => json.encode(data.toJson());

class Vendedor {
  Vendedor({
    this.ciudad,
    this.calle1,
    this.nombreTienda,
    this.calle2,
    this.lat,
    this.long,
    this.phone,
    this.nombre,
    this.url,
  });

  String? ciudad;
  String? calle1;
  String? nombreTienda;
  String? calle2;
  String? lat;
  String? long;
  String? phone;
  String? nombre;
  String? url;

  factory Vendedor.fromJson(Map<String, dynamic> json) => Vendedor(
        ciudad: json["ciudad"],
        calle1: json["calle_1"],
        nombreTienda: json["nombre_tienda"],
        calle2: json["calle_2"],
        lat: json["lat"],
        long: json["long"],
        phone: json["phone"],
        nombre: json["nombre"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "ciudad": ciudad,
        "calle_1": calle1,
        "nombre_tienda": nombreTienda,
        "calle_2": calle2,
        "lat": lat,
        "long": long,
        "phone": phone,
        "nombre": nombre,
        "url": url,
      };
}
