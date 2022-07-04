import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/services/launch_services.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget(
      {Key? key,
      required this.phoneCom,
      required this.phoneVen,
      required this.nameCom,
      required this.nameVen})
      : super(key: key);
  final String phoneCom, phoneVen, nameCom, nameVen;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 97, 206, 112),
              Color.fromARGB(255, 138, 255, 154),
              Color.fromARGB(255, 97, 206, 112)
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 97, 206, 112),
                    Color.fromARGB(255, 138, 255, 154),
                    Color.fromARGB(255, 97, 206, 112)
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                        'assets/images/Logo_ProwessAgronomia.png',
                        fit: BoxFit.contain),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.h),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  persona('Comprador'),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      widget.nameCom,
                      style: TextStyle(
                          fontSize: 18.h, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.h),
                    child: ListTile(
                      leading: const Icon(Icons.phone_forwarded_outlined,
                          color: Colors.black),
                      title: Text(
                        widget.phoneCom,
                        style: TextStyle(
                            fontSize: 18.h, fontWeight: FontWeight.w300),
                      ),
                      onTap: () {
                        launchPhone(widget.phoneCom);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.h),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/whatsapp.png',
                        fit: BoxFit.contain,
                        color: Colors.black,
                        width: 23.h,
                      ),
                      title: Text(
                        'Escríbenos al WhatsApp',
                        style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis),
                      ),
                      onTap: () {
                        launchWhatsApp(widget.phoneCom);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  persona('Vendedor'),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      widget.nameVen,
                      style: TextStyle(
                          fontSize: 18.h, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.h),
                    child: ListTile(
                      leading: const Icon(Icons.phone_forwarded_outlined,
                          color: Colors.black),
                      title: Text(
                        widget.phoneVen,
                        style: TextStyle(
                            fontSize: 18.h, fontWeight: FontWeight.w300),
                      ),
                      onTap: () {
                        launchPhone(widget.phoneVen);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.h),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/whatsapp.png',
                        fit: BoxFit.contain,
                        color: Colors.black,
                        width: 23.h,
                      ),
                      title: Text(
                        'Escríbenos al WhatsApp',
                        style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis),
                      ),
                      onTap: () {
                        launchWhatsApp(widget.phoneVen);
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  FloatingActionButton.extended(
                    onPressed: () {},
                    icon: const Icon(Icons.check, color: Colors.black),
                    label: const Text('Entregar',
                        style: TextStyle(color: Colors.black)),
                    backgroundColor: const Color.fromARGB(255, 97, 206, 112),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget persona(String tipo) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 1.h,
            thickness: 1.h,
            indent: 18.h,
            endIndent: 18.h,
            color: Colors.black,
          ),
        ),
        Text(
          tipo,
          style: TextStyle(fontSize: 25.h, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Divider(
            height: 1.h,
            thickness: 1.h,
            indent: 18.h,
            endIndent: 18.h,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
