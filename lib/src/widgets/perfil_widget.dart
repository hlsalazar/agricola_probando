import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';
import 'package:prowes_motorizado/src/widgets/pedidos_motorizado_widget.dart';
import 'package:prowes_motorizado/src/widgets/stack_container_moto.dart';

class PerfilWidget extends StatefulWidget {
  const PerfilWidget({Key? key}) : super(key: key);

  @override
  State<PerfilWidget> createState() => _PerfilWidgetState();
}

class _PerfilWidgetState extends State<PerfilWidget> {
  TextStyle _styleTitle() {
    return TextStyle(fontSize: 13.h, color: Colors.grey);
  }

  TextStyle _styleContain() {
    return TextStyle(fontSize: 16.h, fontWeight: FontWeight.w600);
  }

  bool _actPedidos = false;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> content = JwtDecoder.decode(mainProvider.token);
    String? _imagenPerfil = content["profileImage"];
    String fechaCad = content["caducidadLic"];
    DateTime date = DateTime.parse(fechaCad);

    return ListView(
      // body: Column(
      children: <Widget>[
        StackContainerMoto(
            imagenPerfil: _imagenPerfil,
            content: content,
            mainProvider: mainProvider),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Icon(Icons.call),
                SizedBox(height: 8.h),
                Text("Teléfono", style: _styleTitle()),
                Text(content["telefono"], style: _styleContain()),
                SizedBox(height: 15.h),
                const Icon(Icons.receipt_outlined),
                Text("Cédula", style: _styleTitle()),
                Text(content["cedula"], style: _styleContain()),
                SizedBox(height: 15.h),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.airport_shuttle_sharp),
                SizedBox(height: 8.h),
                Text("Rol", style: _styleTitle()),
                Text(content["role"], style: _styleContain()),
                SizedBox(height: 15.h),
                const Icon(Icons.sticky_note_2),
                Text("Placa Vehiculo", style: _styleTitle()),
                Text(content["numPlaca"], style: _styleContain()),
                SizedBox(height: 15.h),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.receipt_outlined),
                SizedBox(height: 8.h),
                Text("Tipo de Licencia", style: _styleTitle()),
                Text(content["tipoLic"], style: _styleContain()),
                SizedBox(height: 15.h),
                const Icon(Icons.date_range_sharp),
                Text("F. de Caducidad", style: _styleTitle()),
                Text('${date.day} / ${date.month} / ${date.year}',
                    style: _styleContain()),
                SizedBox(height: 15.h),
              ],
            )
          ],
        ),
        const Icon(Icons.mail_outline),
        Text("Correo", textAlign: TextAlign.center, style: _styleTitle()),
        Text(
          content["email"],
          textAlign: TextAlign.center,
          style: _styleContain(),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 10.h),
        Container(
          margin: EdgeInsets.fromLTRB(25.h, 5.h, 25.h, 5.h),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.h),
              borderRadius: BorderRadius.circular(18.h)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Image(
                        image: const AssetImage('assets/images/pedido.png'),
                        width: 30.h),
                  ),
                  InkWell(
                    child: Text(
                      "Mis Pedidos",
                      style: TextStyle(
                          fontSize: 18.h, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _actPedidos = !_actPedidos;
                      setState(() {});
                    },
                  ),
                  Icon(
                      !_actPedidos
                          ? Icons.navigate_next
                          : Icons.arrow_drop_down,
                      color: Colors.grey)
                ],
              ),
              !_actPedidos ? SizedBox(width: 1.h) : const PedidoMotorizado()
            ],
          ),
        ),
      ],
      // ),
    );
  }
}
