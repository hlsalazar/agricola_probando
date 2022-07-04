import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/services/launch_services.dart';

class ContactosWidget extends StatelessWidget {
  const ContactosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Dr. Luis Simbaña Taipe",
              style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.h, 5.h, 30.h, 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Whatsapp: ",
                  style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Image(
                        image: const AssetImage('assets/images/whatsapp.png'),
                        width: 20.h),
                    SizedBox(width: 8.h),
                    buildRaisedButton("Envíanos un mensaje", launchURL),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  "Correo Eléctronico: ",
                  style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Image(
                        image: const AssetImage('assets/images/email.png'),
                        width: 23.h),
                    const SizedBox(width: 3),
                    buildRaisedButton(
                        "prowessagronomia@gmail.com", lauchCorreoElectronico),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Teléfono: ",
                  style: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image(
                        image: const AssetImage('assets/images/telefono.png'),
                        width: 23.h),
                    const SizedBox(width: 5),
                    buildRaisedButton(" +593 99 816 0293", launchLlamada)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildRaisedButton(String text, dynamic event) {
    return Expanded(
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14.h,
              color: const Color.fromARGB(255, 115, 178, 26)),
        ),
        onTap: event,
      ),
    );
  }
}
