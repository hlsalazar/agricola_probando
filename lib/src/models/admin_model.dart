// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
    Admin({
        this.email,
        this.password,
        this.displayName,
        this.telefono,
        this.cedula,
        this.profileImage,
        this.role,
    });

    String? email;
    String? password;
    String? displayName;
    String? telefono;
    String? cedula;
    String? profileImage;
    String? role;

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        email: json["email"],
        password: json["password"],
        displayName: json["displayName"],
        telefono: json["telefono"],
        cedula: json["cedula"],
        profileImage: json["profileImage"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "displayName": displayName,
        "telefono": telefono,
        "cedula": cedula,
        "profileImage": profileImage,
        "role": role,
    };
}