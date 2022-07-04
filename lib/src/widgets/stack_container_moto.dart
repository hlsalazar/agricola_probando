import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';

class StackContainerMoto extends StatelessWidget {
  const StackContainerMoto({
    Key? key,
    required String? imagenPerfil,
    required this.content,
    required this.mainProvider,
  })  : _imagenPerfil = imagenPerfil,
        super(key: key);

  final String? _imagenPerfil;
  final Map<String, dynamic> content;
  final MainProvider mainProvider;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 278.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper1(),
            child: Container(
              height: 180.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/motorizado.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              //color: Colors.green[300],
            ),
          ),
          Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.green.shade300,
                  radius: 63.h,
                  child: CircleAvatar(
                    radius: 59.h,
                    backgroundImage: NetworkImage(_imagenPerfil ?? ""),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(content["name"],
                    style:
                        TextStyle(fontSize: 25.h, fontWeight: FontWeight.bold)),
                IconButton(
                    tooltip: 'Cerrar Sesión',
                    onPressed: () => mainProvider.token = "",
                    icon: const Icon(Icons.logout)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 165);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
