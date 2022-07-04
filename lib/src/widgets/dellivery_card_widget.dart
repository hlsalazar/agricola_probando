import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/models/comprador_model.dart';
import 'package:prowes_motorizado/src/models/pedido_model.dart';
import 'package:prowes_motorizado/src/pages/detallepedidos_page.dart';

class DeliveryCardWidget extends StatelessWidget {
  const DeliveryCardWidget({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    Comprador? comprador = pedido.comprador;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.h, vertical: 2.h),
      child: Card(
        elevation: 3,
        shadowColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1.h),
          borderRadius: BorderRadius.circular(15.h),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetallePedido(pedido: pedido),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.h),
                  child: Text(
                    pedido.numPedido ?? "",
                    style: TextStyle(
                      fontSize: 13.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(4.h)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comprador!.nombre ?? "",
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Calle Principal: " + comprador.dir1!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Calle Secundaria: " + comprador.dir2!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text("Telefono: " + comprador.phone!),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  child: CircleAvatar(
                      backgroundImage:
                          const AssetImage("assets/images/libre.png"),
                      backgroundColor: Colors.lime,
                      radius: 18.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
