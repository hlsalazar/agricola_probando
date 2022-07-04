// To parse this JSON data, do
//
//     final pedido = pedidoFromJson(jsonString);

import 'dart:convert';

import 'package:prowes_motorizado/src/models/comprador_model.dart';
import 'package:prowes_motorizado/src/models/detalle_model.dart';
import 'package:prowes_motorizado/src/models/pago_model.dart';
import 'package:prowes_motorizado/src/models/vendedor_model.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido(
      {this.numPedido,
      this.uidMot,
      this.estado,
      this.fecha,
      this.comprador,
      this.vendedor,
      this.detalle,
      this.pago});

  String? numPedido;
  String? uidMot;
  String? estado;
  String? fecha;
  Comprador? comprador;
  Vendedor? vendedor;
  List<Detalle>? detalle;
  Pago? pago;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        numPedido: json["num_pedido"],
        uidMot: json["uid_mot"],
        estado: json["estado"],
        fecha: json["fecha"],
        comprador: Comprador.fromJson(json["comprador"]),
        vendedor: Vendedor.fromJson(json["vendedor"]),
        pago: Pago.fromJson(json["pago"]),
        detalle:
            List<Detalle>.from(json["detalle"].map((x) => Detalle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num_pedido": numPedido,
        "uid_mot": uidMot,
        "estado": estado,
        "fecha": fecha,
        "comprador": comprador!.toJson(),
        "vendedor": vendedor!.toJson(),
        "detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
        "pago": pago!.toJson(),
      };
}
