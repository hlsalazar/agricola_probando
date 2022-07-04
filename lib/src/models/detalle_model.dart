// To parse this JSON data, do
//
//     final detalle = detalleFromJson(jsonString);

import 'dart:convert';

Detalle detalleFromJson(String str) => Detalle.fromJson(json.decode(str));

String detalleToJson(Detalle data) => json.encode(data.toJson());

class Detalle {
  Detalle({
    this.cantidad,
    this.nombre,
    this.precio,
    this.subtotal,
    this.total,
  });

  int? cantidad;
  String? nombre;
  String? total;
  String? subtotal;
  double? precio;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        cantidad: json["cantidad"],
        nombre: json["nombre"],
        subtotal: json["subtotal"],
        total: json["total"],
        precio: json["precio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
        "nombre": nombre,
        "precio": precio,
        "total": total,
        "subtotal": subtotal,
      };
}
