import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prowes_motorizado/src/services/pedidos_service.dart';

final PedidoService _pedidoService = PedidoService();

class DistanciaWidget extends StatefulWidget {
  const DistanciaWidget({Key? key, required this.idPedido}) : super(key: key);
  final String idPedido;

  @override
  State<DistanciaWidget> createState() => _DistanciaWidgetState();
}

class _DistanciaWidgetState extends State<DistanciaWidget> {
  double _distancia = 0;
  final double _precioKm = 0.25;

  @override
  void initState() {
    _distanciaValor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String aux2 = (_distancia! * 0.25).toStringAsFixed(2);
    //widget.id ? _disred = 'Distancia: $aux1 km' : _disred = 'Total: $aux2 ';
    return Container(
      margin: EdgeInsets.all(12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Precio Delivery",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.h),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 60.h,
                    child: Image.asset('assets/images/delivery-man.png'),
                  ),
                  Text("Distancia: " + _distancia.toString() + " km"),
                ],
              ),
              Divider(
                height: 5.h,
                endIndent: 5.h,
                indent: 5.h,
                color: Colors.black,
                thickness: 1.h,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 60.h,
                    child: Image.asset('assets/images/dollar-symbol.png'),
                  ),
                  Text("Total: " +
                      double.parse((_distancia * _precioKm).toStringAsFixed(2))
                          .toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _distanciaValor() async {
    Map<String, dynamic>? _resp =
        await _pedidoService.getAddress(widget.idPedido);
    _distancia = GeolocatorPlatform.instance.distanceBetween(
          double.parse(_resp["latVen"]),
          double.parse(_resp["longVen"]),
          double.parse(_resp["latCom"]),
          double.parse(_resp["longCom"]),
        ) /
        1000;
    _distancia = double.parse(_distancia.toStringAsFixed(3));
    if (mounted) {
      setState(() {});
    }
  }
}
