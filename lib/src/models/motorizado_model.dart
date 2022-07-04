import 'dart:convert';

//Variable global para el tipo de transporte
Motorizado motorizadoFromJson(String str) =>
    Motorizado.fromJson(json.decode(str));

String motorizadoToJson(Motorizado data) => json.encode(data.toJson());

class Motorizado {
  Motorizado({
    this.email,
    this.password,
    this.displayName,
    this.telefono,
    this.direccion,
    this.cedula,
    this.tipoLic,
    this.caducidadLic,
    this.numPlaca,
    this.colorVeh,
    this.profileImage,
    this.role,
  });

  String? email;
  String? password;
  String? displayName;
  String? telefono;
  String? direccion;
  String? cedula;
  String? tipoLic;
  String? caducidadLic;
  String? numPlaca;
  String? colorVeh;
  String? profileImage;
  String? role;

  factory Motorizado.fromJson(Map<String, dynamic> json) => Motorizado(
        email: json["email"],
        password: json["password"],
        displayName: json["displayName"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        cedula: json["cedula"],
        tipoLic: json["tipoLic"],
        caducidadLic: json["caducidadLic"],
        numPlaca: json["numPlaca"],
        colorVeh: json["colorVeh"],
        profileImage: json["profileImage"],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "displayName": displayName,
        "telefono": telefono,
        "direccion": direccion,
        "cedula": cedula,
        "tipoLic": tipoLic,
        "caducidadLic": caducidadLic,
        "numPlaca": numPlaca,
        "colorVeh": colorVeh,
        "profileImage": profileImage,
        "role": role,
      };
}
