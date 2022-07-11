import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prowes_motorizado/src/services/pedidos_service.dart';

late double distance;
// ignore: unused_element
late Marker _origin;
// ignore: unused_element
late Marker _destination;

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key, required this.idPedido}) : super(key: key);
  final String idPedido;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];
  Position? _position;
  CameraPosition _latacunga = const CameraPosition(
    target: LatLng(-0.933333, -78.6167),
    zoom: 14,
  );

  final PedidoService _pedidoService = PedidoService();
  @override
  void initState() {
    super.initState();
    _obtenerPosicion();
    _downloadAddres();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (_position != null) {
        _latacunga = CameraPosition(
          target: LatLng(_position!.latitude, _position!.longitude),
          zoom: 16,
        );
        Marker marker = Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
            markerId: const MarkerId("Motorizado"),
            infoWindow: const InfoWindow(title: "Ubicación Actual"),
            position: LatLng(_position!.latitude, _position!.longitude));
        _markers.add(marker);
      }

      return GoogleMap(
        markers: Set<Marker>.of(_markers),
        mapType: MapType.normal,
        initialCameraPosition: _latacunga,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
    });
  }

  _downloadAddres() async {
    Map<String, dynamic>? _resp =
        await _pedidoService.getAddress(widget.idPedido);
    if (mounted) {
      setState(() {});
    }

    _origin = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: const MarkerId('Comprador'),
        position: LatLng(
            double.parse(_resp["latCom"]), double.parse(_resp["longCom"])),
        infoWindow: const InfoWindow(title: 'Comprador'));

    _destination = (Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        markerId: const MarkerId('Vendedor'),
        position: LatLng(
            double.parse(_resp["latVen"]), double.parse(_resp["longVen"])),
        infoWindow: const InfoWindow(title: 'Vendedor')));

    //distance = GeolocatorPlatform.instance.bearingBetween(double.parse(_resp["latVen"]),double.parse(_resp["longVen"]), double.parse(_resp["latCom"]), double.parse(_resp["longCom"]));
    distance = GeolocatorPlatform.instance.distanceBetween(
        double.parse(_resp["latVen"]),
        double.parse(_resp["longVen"]),
        double.parse(_resp["latCom"]),
        double.parse(_resp["longCom"]));
  }

  Future<Position> _determinarPosicion() async {
    //Cuando los servisioes de localización ested desabilitados
    //la función devolverá un error
    bool servicioHabilitado;
    LocationPermission permiso;
    //Prueba si los servicios de localización estan habilitados
    servicioHabilitado = await Geolocator.isLocationServiceEnabled();

    if (!servicioHabilitado) {
      // dev.log('Los servicios de localización están desabilitados');
      _printAlert(
          "Para el Uso correcto de la App\nActive la localización de su dispositivo\nLuego recarge la página");
      return Position(
          longitude: -78.566032,
          latitude: -0.512255,
          timestamp: DateTime.now(),
          accuracy: 0.45,
          altitude: -0.45,
          heading: 0.8,
          speed: 0.34,
          speedAccuracy: 4.5);
    }

    //Compruebo que exista permisos
    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied ||
          permiso == LocationPermission.deniedForever) {
        return Position(
            longitude: -78.566032,
            latitude: -0.512255,
            timestamp: DateTime.now(),
            accuracy: 0.45,
            altitude: -0.45,
            heading: 0.8,
            speed: 0.34,
            speedAccuracy: 4.5);
      }
    }

    //Cuando llegue aquí, los permisos han sido aceptados
    //Se puede acceder a la posición del dispositivo
    //dev.log('localización:         ..' +  Geolocator.getCurrentPosition().toString());
    return await Geolocator.getCurrentPosition();
  }

  _obtenerPosicion() async {
    // ignore: unused_local_variable
    Map<String, dynamic>? _resp =
        await _pedidoService.getAddress(widget.idPedido);
    _position = await _determinarPosicion();
    setState(() {});
  }

  _printAlert(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alerta'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Aceptar'),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
