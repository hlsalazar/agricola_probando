import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/widgets/contactos_widget.dart';
import 'package:prowes_motorizado/src/widgets/redes_sociales_widget.dart';

class OpcionesWidget extends StatefulWidget {
  const OpcionesWidget({Key? key}) : super(key: key);

  @override
  State<OpcionesWidget> createState() => _OpcionesWidgetState();
}

class _OpcionesWidgetState extends State<OpcionesWidget> {
  bool _actContactos = false;
  bool _actRedes = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                            child: Image.asset('assets/images/eleccion.png')),
                        SizedBox(width: 15.h),
                        Text(
                          "Opciones",
                          style: TextStyle(
                              fontSize: 18.h, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              margin: EdgeInsets.fromLTRB(25.h, 5.h, 25.h, 5.h),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.h),
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
                            image:
                                const AssetImage('assets/images/contactos.png'),
                            width: 30.h),
                      ),
                      InkWell(
                        child: Text(
                          "Contactos",
                          style: TextStyle(
                              fontSize: 18.h, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _actContactos = !_actContactos;
                          setState(() {});
                        },
                      ),
                      Icon(
                          !_actContactos
                              ? Icons.navigate_next
                              : Icons.arrow_drop_down,
                          color: Colors.grey),
                    ],
                  ),
                  !_actContactos
                      ? SizedBox(width: 1.h)
                      : const ContactosWidget()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25.h, 5.h, 25.h, 5.h),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.h),
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
                            image: const AssetImage('assets/images/redes.png'),
                            width: 30.h),
                      ),
                      InkWell(
                        child: Text(
                          "Redes Sociales",
                          style: TextStyle(
                              fontSize: 18.h, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _actRedes = !_actRedes;
                          setState(() {});
                        },
                      ),
                      Icon(
                          !_actRedes
                              ? Icons.navigate_next
                              : Icons.arrow_drop_down,
                          color: Colors.grey)
                    ],
                  ),
                  !_actRedes
                      ? SizedBox(width: 1.h)
                      : const RedesSocialesWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
