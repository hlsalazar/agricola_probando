import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/widgets/pedidos_motorizado_widget.dart';

class PedidosMotorizadoPage extends StatelessWidget {
  const PedidosMotorizadoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const PedidoMotorizado(),
    );
  }
}
