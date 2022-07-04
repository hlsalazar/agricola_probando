import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/pages/pedidos_motorizado_page.dart';

class TransporteWidget extends StatefulWidget {
  const TransporteWidget({Key? key}) : super(key: key);

  @override
  State<TransporteWidget> createState() => _TransporteWidgetState();
}

class _TransporteWidgetState extends State<TransporteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: ExitMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 20.h, left: 50.h, right: 50.h, bottom: 20.h),
                child: Material(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16.h),
                  child: SizedBox(
                    height: 60.h,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 40.h,
                              width: 50.h,
                              child:
                                  Image.asset('assets/images/Transporte.png')),
                          SizedBox(width: 15.h),
                          Text(
                            "Transporte",
                            style: TextStyle(
                                fontSize: 18.h, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: MaterialButton(
                  minWidth: 300.h,
                  height: 50.h,
                  color: const Color.fromARGB(255, 97, 206, 112),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.h)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PedidosMotorizadoPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: Image.asset('assets/images/bicicleta.png')),
                      SizedBox(width: 15.h),
                      Text(
                        "Ver Motorizados",
                        style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              //Ver CAMIONETAS
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: MaterialButton(
                  minWidth: 300.h,
                  height: 50.h,
                  color: const Color.fromARGB(255, 97, 206, 112),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.h)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PedidosMotorizadoPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: Image.asset('assets/images/Camioneta.png')),
                      SizedBox(width: 15.h),
                      Text(
                        "Ver Camionetas",
                        style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              //Ver CAMIONES
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: MaterialButton(
                  minWidth: 300.h,
                  height: 50.h,
                  color: const Color.fromARGB(255, 97, 206, 112),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.h)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const PedidosMotorizadoPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 30.h,
                          width: 30.h,
                          child: Image.asset('assets/images/camionC.png')),
                      SizedBox(width: 15.h),
                      Text(
                        "Ver Camiones",
                        style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
