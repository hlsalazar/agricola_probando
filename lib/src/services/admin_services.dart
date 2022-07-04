import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:prowes_motorizado/src/models/admin_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AdminServices {
  AdminServices();
  final String _rootUrl =
      "https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/createAdmin";

  Future<int> postAdmid(Admin administrador) async {
    try {
      final Map<String, String> _headers = {"content-type": "application/json"};
      String _usuarioBody = adminToJson(administrador);
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
    final cloudinary = CloudinaryPublic('dydttkb7s', 'ml_default', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image, folder: "prowess/usuario/"),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      return "" + e.toString();
    }
  }

}
