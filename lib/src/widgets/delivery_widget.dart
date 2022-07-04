import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/models/pedido_model.dart';
import 'package:prowes_motorizado/src/services/pedidos_service.dart';
import 'package:prowes_motorizado/src/widgets/dellivery_card_widget.dart';

class DeliveryWidget extends StatefulWidget {
  const DeliveryWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryWidget> createState() => _DeliveryWidgetState();
}

class _DeliveryWidgetState extends State<DeliveryWidget> {
  final PedidoService _pedidoService = PedidoService();
  List<Pedido>? _pedidos;

  @override
  void initState() {
    super.initState();
    _downloadPedido();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 50.h, right: 50.h),
            child: Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16.h),
              child: SizedBox(
                height: 50.h,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 40.h,
                          width: 40.h,
                          child:
                              Image.asset('assets/images/delivery-truck.png')),
                      SizedBox(width: 15.h),
                      Text(
                        "Pedidos",
                        style: TextStyle(
                            fontSize: 18.h, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
            width: 15.h,
          ),
          Expanded(
            child: _pedidos == null
                ? const SizedBox()
                : _pedidos!.isEmpty
                    ? const Center(child: Text("No hay Pedidos Disponibles..."))
                    : RefreshIndicator(
                        onRefresh: () async {
                          _pedidos = await _pedidoService.getPedido();
                          setState(() {});
                        },
                        child: ListView(
                          children: _pedidos!
                              .map((e) => DeliveryCardWidget(pedido: e))
                              .toList(),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  _downloadPedido() async {
    _pedidos = await _pedidoService.getPedido();
    if (mounted) {
      setState(() {});
    }
  }
}
