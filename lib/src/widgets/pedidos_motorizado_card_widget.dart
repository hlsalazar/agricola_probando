import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:prowes_motorizado/src/models/comprador_model.dart';
import 'package:prowes_motorizado/src/models/pedido_model.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';

class PedidoCardMotorizado extends StatelessWidget {
  const PedidoCardMotorizado({Key? key, required this.pedido})
      : super(key: key);
  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> content = JwtDecoder.decode(mainProvider.token);
    final Comprador? comprador = pedido.comprador;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: pedido.uidMot == content["user_id"]
            ? Card(
                elevation: 3,
                shadowColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: 1.h),
                  borderRadius: BorderRadius.circular(15.h),
                ),
                child: Container(
                  margin: EdgeInsets.all(3.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          pedido.numPedido ?? "",
                          style: TextStyle(
                            fontSize: 13.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.all(2.h)),
                              Text(
                                comprador!.nombre ?? "",
                                style: TextStyle(
                                  fontSize: 15.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("Telefono: " + comprador.phone!),
                              Padding(padding: EdgeInsets.all(2.h)),
                            ]),
                        pedido.estado == "en proceso"
                            ? CircleAvatar(
                                backgroundImage: const AssetImage(
                                    "assets/images/espera.png"),
                                backgroundColor: Colors.red,
                                radius: 15.h)
                            : pedido.estado == "libre"
                                ? CircleAvatar(
                                    backgroundImage: const AssetImage(
                                        "assets/images/libre.png"),
                                    backgroundColor: Colors.yellow,
                                    radius: 15.h)
                                : CircleAvatar(
                                    backgroundImage: const AssetImage(
                                        "assets/images/entregado.png"),
                                    backgroundColor: Colors.yellow,
                                    radius: 15.h)
                      ]),
                ),
              )
            : null);
  }
}
