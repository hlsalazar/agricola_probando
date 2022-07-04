// ignore_for_file: prefer_const_constructors, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:prowes_motorizado/src/models/comprador_model.dart';
import 'package:prowes_motorizado/src/models/detalle_model.dart';
import 'package:prowes_motorizado/src/models/pedido_model.dart';
import 'package:prowes_motorizado/src/models/vendedor_model.dart';
import 'package:prowes_motorizado/src/pages/location_page.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';
import 'package:prowes_motorizado/src/services/pedidos_service.dart';
import 'package:prowes_motorizado/src/widgets/distancia_widget.dart';
import 'package:prowes_motorizado/src/widgets/scrollable_widget.dart';

class DetallePedido extends StatefulWidget {
  const DetallePedido({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  State<DetallePedido> createState() => _DetallePedidoState();
}

class _DetallePedidoState extends State<DetallePedido> {
  final PedidoService _pedidoService = PedidoService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> content = JwtDecoder.decode(mainProvider.token);
    List<Detalle> detalle = widget.pedido.detalle!.toList();
    Vendedor? vendedor = widget.pedido.vendedor;
    Comprador? comprador = widget.pedido.comprador;
    String uidMot = content["user_id"];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(97, 206, 112, 1),
        onPressed: () async {
          int estado = await _pedidoService.putEstado(
              "en proceso", uidMot, widget.pedido.numPedido ?? "");

          if (estado == 200) {
            const snackBar = SnackBar(
              content: Text('Pedido Aceptado...'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    PageLocation(idPedido: widget.pedido.numPedido ?? ""),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
        tooltip: "Aceptar Pedido",
        elevation: 12.h,
      ),
      appBar: AppBar(
        elevation: 10.h,
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
      body: SingleChildScrollView(
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
                              Image.asset('assets/images/delivery-truck.png'),
                        ),
                        SizedBox(width: 15.h),
                        Text(
                          "Detalles de Pedido",
                          style: TextStyle(
                            fontSize: 22.h,
                            fontWeight: FontWeight.bold,
                          ),
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
            Card(
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    title: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40.h,
                              width: 40.h,
                              child: Image.asset('assets/images/vendedor.png'),
                            ),
                            ScrollableWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Vendedor',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Nombre: ' +
                                        vendedor!.nombre.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Telefono: ' +
                                        vendedor.phone.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Ciudad: ' +
                                        vendedor.ciudad.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text(
                                        'Calle: ' + vendedor.calle1.toString()),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 8.h,
                          color: Colors.black,
                          thickness: 1.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 40.h,
                              width: 60.h,
                              child: Image.asset('assets/images/comprador.png'),
                            ),
                            ScrollableWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Comprador',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Nombre: ' +
                                        comprador!.nombre.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Telefono: ' +
                                        comprador.phone.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Ciudad: ' +
                                        comprador.ciudad.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
                                    child: Text('Calle: ' +
                                        comprador.ciudad.toString()),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 8.h,
                    endIndent: 5.h,
                    indent: 5.h,
                    color: Colors.black,
                    thickness: 1.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Productos',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.h),
                  ),
                  ScrollableWidget(
                    child: Column(
                      children: detalle.map((e) => listProduc(e)).toList(),
                    ),
                  ),
                  DistanciaWidget(
                    idPedido: widget.pedido.numPedido.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listProduc(Detalle detalle) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Cantidad')),
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('P. Unitario')),
        DataColumn(label: Text('Total')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text(detalle.cantidad.toString())),
          DataCell(Text(detalle.nombre.toString())),
          DataCell(Text(detalle.precio.toString())),
          DataCell(Text(detalle.total.toString())),
        ]),
      ],
    );
  }
}
