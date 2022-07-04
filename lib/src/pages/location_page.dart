import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prowes_motorizado/src/services/pedidos_service.dart';
import 'package:prowes_motorizado/src/widgets/drawer_widget.dart';

class PageLocation extends StatefulWidget {
  const PageLocation({Key? key, required this.idPedido}) : super(key: key);
  final String idPedido;

  @override
  State<PageLocation> createState() => _PageLocationState();
}

class _PageLocationState extends State<PageLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];
  Set<Polyline> _polyline = {};

  List<LatLng> latLines = [];

  String? phoneCom, phoneVen, nameCom, nameVen;

  Position? _position;
  late CameraPosition _Latacunga = const CameraPosition(
    target: LatLng(-0.9324760840048609, -78.61793541360251),
    zoom: 14,
  );

  final PedidoService _pedidoService = PedidoService();

  @override
  void initState() {
    super.initState();
    _obtenerPosicion();
    _downloadAddres();
    _obtenerlinea();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        phoneCom: phoneCom ?? "",
        phoneVen: phoneVen ?? "",
        nameCom: nameCom ?? "",
        nameVen: nameVen ?? "",
      ),
      appBar: AppBar(
        elevation: 10.h,
        actions: [
          IconButton(
              onPressed: () {
                _obtenerPosicion();
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh_outlined,
                color: Colors.black,
                semanticLabel: "Actualizar",
              ))
        ],
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 20.h,
          tooltip: 'Regresar',
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 97, 206, 112),
                Color.fromARGB(255, 138, 255, 154),
                Color.fromARGB(255, 97, 206, 112)
              ])),
        ),
        toolbarHeight: 85.h,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo_ProwessAgronomia.png',
          fit: BoxFit.contain,
          height: 150.h,
          width: 150.h,
        ),
      ),
      body: Builder(builder: (context) {
        if (_position != null) {
          _Latacunga = CameraPosition(
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
          polylines: _polyline,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          initialCameraPosition: _Latacunga,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
      }),
    );
  }

  _downloadAddres() async {
    Map<String, dynamic>? _resp =
        await _pedidoService.getAddress(widget.idPedido);
    if (mounted) {
      setState(() {});
    }

    phoneCom = _resp["telefonoCom"];
    phoneVen = _resp["telefonoVen"];
    nameCom = _resp["nameCom"];
    nameVen = _resp["nameVen"];
    _markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: const MarkerId('Comprador'),
        position: LatLng(
            double.parse(_resp["latCom"]), double.parse(_resp["longCom"])),
        infoWindow: const InfoWindow(title: 'Comprador')));

    _markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        markerId: const MarkerId('Vendedor'),
        position: LatLng(
            double.parse(_resp["latVen"]), double.parse(_resp["longVen"])),
        infoWindow: const InfoWindow(title: 'Vendedor')));
    latLines.add(
      LatLng(double.parse(_resp["latCom"]), double.parse(_resp["longCom"])),
    );
    latLines.add(
      LatLng(double.parse(_resp["latVen"]), double.parse(_resp["longVen"])),
    );
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
    _position = await _determinarPosicion();
    setState(() {});
  }

  _obtenerlinea() async {
    _polyline.add(Polyline(
      polylineId: PolylineId('route'),
      points: latLines,
      color: Colors.orange,
      width: 6,
    ));
  }

  _printAlert(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alerta'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Aceptar'),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
