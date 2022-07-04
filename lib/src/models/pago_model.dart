// To parse this JSON data, do
//
//     final pago = pagoFromJson(jsonString);

import 'dart:convert';

Pago pagoFromJson(String str) => Pago.fromJson(json.decode(str));

String pagoToJson(Pago data) => json.encode(data.toJson());

class Pago {
  Pago({
    this.monedaSymbol,
    this.totalTax,
    this.moneda,
    this.total,
    this.tipoDePago,
  });

  String? monedaSymbol;
  String? totalTax;
  String? moneda;
  String? total;
  String? tipoDePago;

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
        monedaSymbol: json["moneda_symbol"],
        totalTax: json["total_tax"],
        moneda: json["moneda"],
        total: json["total"],
        tipoDePago: json["tipo_de_pago"],
      );

  Map<String, dynamic> toJson() => {
        "moneda_symbol": monedaSymbol,
        "total_tax": totalTax,
        "moneda": moneda,
        "total": total,
        "tipo_de_pago": tipoDePago,
      };
}
