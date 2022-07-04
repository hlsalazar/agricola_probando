import 'dart:convert';

import 'dart:developer' as developer;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prowes_motorizado/src/models/motorizado_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class UsuarioService {
  UsuarioService();
  final String _firebaseAPIKey = 'AIzaSyAomBw7DB8MMjK8NsMQrcvN71wQgCwUNAo';
  final String _rootUrl =
      "https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/createUser";
  final String _urlResetPassword =
      'https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/resetPassword';

  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      var uri = Uri.parse(_urlResetPassword);
      final body = {"email": email};
      final Map<String, String> _headers = {"content-type": "application/json"};

      var response =
          await http.post(uri, body: json.encode(body), headers: _headers);
      if (response.body.isEmpty) return <String, dynamic>{};
      Map<String, dynamic> decodedResp = json.decode(response.body);
      return decodedResp;
    } catch (e) {
      developer.log(e.toString());
      return <String, dynamic>{'message': 'Error algo salio mal'};
    }
  }

  Future<Map<String, dynamic>> login(Motorizado usuario) async {
    try {
      final loginBody = {
        "email": usuario.email,
        "password": usuario.password,
        "returnSecureToken": true
      };
      final queryParams = {"key": _firebaseAPIKey};
      var uri = Uri.https("www.googleapis.com",
          "/identitytoolkit/v3/relyingparty/verifyPassword", queryParams);
      var response = await http.post(uri, body: json.encode(loginBody));
      if (response.body.isEmpty) return <String, dynamic>{};
      Map<String, dynamic> decodedResp = json.decode(response.body);
      developer.log(decodedResp.toString());
      return decodedResp;
    } catch (e) {
      developer.log(e.toString());
      return <String, dynamic>{};
    }
  }

  Future<int> postMotorizado(Motorizado motorizado) async {
    try {
      final Map<String, String> _headers = {"content-type": "application/json"};
      String _usuarioBody = motorizadoToJson(motorizado);
      var url = Uri.parse(_rootUrl);
      final response =
          await http.post(url, body: _usuarioBody, headers: _headers);
      if (response.body.isEmpty) return 400;
      return response.statusCode;
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      return 500;
    }
  }

  Future<String> uploadImage(File image) async {
    final cloudinary =
        CloudinaryPublic('dydttkb7s', 'ml_default', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image,
            folder: "prowess/usuario/"),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      return "" + e.toString();
    }
  }
}
