import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/models/pedido_model.dart';
import 'package:prowes_motorizado/src/services/pedidos_service.dart';
import 'package:prowes_motorizado/src/widgets/pedidos_motorizado_card_widget.dart';

class PedidoMotorizado extends StatefulWidget {
  const PedidoMotorizado({Key? key}) : super(key: key);

  @override
  State<PedidoMotorizado> createState() => _PedidoMotorizado();
}

class _PedidoMotorizado extends State<PedidoMotorizado> {
  final PedidoService _pedidoService = PedidoService();
  List<Pedido>? _pedidos;

  @override
  void initState() {
    super.initState();
    _downloadPedido();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.h),
      child: _pedidos == null
          ? const SizedBox()
          : _pedidos!.isEmpty
              ? const Center(child: Text("No tiene Pedidos"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _pedidos!
                      .map((e) => PedidoCardMotorizado(pedido: e))
                      .toList()),
    );
  }

  _downloadPedido() async {
    _pedidos = await _pedidoService.getPedidoM();
    if (mounted) {
      setState(() {});
    }
  }
}
