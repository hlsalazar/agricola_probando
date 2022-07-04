import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prowes_motorizado/src/models/pedido_model.dart';

class PedidoService {
  PedidoService();
  final String _rootUrl =
      "https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/listPedido";

  final String _rootUrlEstado =
      "https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/estadoPedido";

  final String _rootUrlAddress =
      "https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/address";

  final String _rootUrlPedido =
      "https://us-central1-prowes-app-agricola.cloudfunctions.net/app/api/Pedido";

  Future<List<Pedido>?> getPedido() async {
    List<Pedido> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final pedido = Pedido.fromJson(item);
        result.add(pedido);
      }
      return result;
    } catch (ex) {
      return result;
    }
  }

  Future<int> putEstado(String estado, String uidMot, String id) async {
    try {
      var uri = Uri.parse('$_rootUrlEstado/$id');
      final estadoBody = {"estado": estado, "uid_mot": uidMot};
      final Map<String, String> _headers = {"content-type": "application/json"};

      var response =
          await http.put(uri, headers: _headers, body: json.encode(estadoBody));

      if (response.statusCode == 400) return 400;

      int result = response.statusCode;
      return result;
    } catch (ex) {
      return 500;
    }
  }

  Future<Map<String, dynamic>> getAddress(String id) async {
    try {
      var url = Uri.parse('$_rootUrlAddress/$id');
      final response = await http.get(url);
      if (response.body.isEmpty) {
        return <String, dynamic>{"mensaje": "No hay direcciones"};
      }
      Map<String, dynamic> decodedResp = json.decode(response.body);
      return decodedResp;
    } catch (ex) {
      return <String, dynamic>{"mensaje": "Ha ocurrido un error $ex"};
    }
  }

  Future<List<Pedido>?> getPedidoM() async {
    List<Pedido> result = [];
    try {
      var url = Uri.parse(_rootUrlPedido);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final pedido = Pedido.fromJson(item);
        result.add(pedido);
      }
      return result;
    } catch (ex) {
      return result;
    }
  }
}
