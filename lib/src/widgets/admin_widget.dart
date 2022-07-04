import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:prowes_motorizado/src/pages/singup_admin_page.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';
import 'package:prowes_motorizado/src/widgets/stack_container.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({Key? key}) : super(key: key);

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  TextStyle _styleTitle() {
    return TextStyle(fontSize: 13.h, color: Colors.grey);
  }

  TextStyle _styleContain() {
    return TextStyle(fontSize: 16.h, fontWeight: FontWeight.w600);
  }

  final double _profileHeight = 150.h;
  late String _imagenPerfil;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> content = JwtDecoder.decode(mainProvider.token);
    String? _imagenPerfil = content["profileImage"];
    return Scaffold(
      body: Column(
        children: <Widget>[
          StackContainer(
              imagenPerfil: _imagenPerfil,
              content: content,
              mainProvider: mainProvider),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.receipt_outlined),
                  SizedBox(height: 8.h),
                  Text("Cédula", style: _styleTitle()),
                  Text(content["cedula"], style: _styleContain()),
                  SizedBox(height: 8.h),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.account_circle_sharp),
                  SizedBox(height: 8.h),
                  Text("Rol", style: _styleTitle()),
                  Text(content["role"], style: _styleContain()),
                  SizedBox(height: 8.h),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.call),
                  SizedBox(height: 8.h),
                  Text("Teléfono", style: _styleTitle()),
                  Text(content["telefono"], style: _styleContain()),
                  SizedBox(height: 8.h),
                ],
              )
            ],
          ),
          SizedBox(height: 8.h),
          const Icon(Icons.mail_outline),
          Text("Correo", style: _styleTitle()),
          Text(
            content["email"],
            style: _styleContain(),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: MaterialButton(
              minWidth: 250.h,
              height: 50.h,
              color: const Color.fromARGB(255, 97, 206, 112),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.h)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SingupAdmin()));
              },
              child: const Text(
                "Registrar Administrador",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage() => CircleAvatar(
      radius: _profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(_imagenPerfil));
}
