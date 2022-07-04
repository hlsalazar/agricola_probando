import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class RedesSocialesWidget extends StatelessWidget {
  const RedesSocialesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.h, 15.h, 0, 15.h),
                    child: InkWell(
                        child: Image(
                            image:
                                const AssetImage('assets/images/instagram.png'),
                            width: 35.h),
                        onTap: () => launch(
                            'https://www.instagram.com/prowessagro_ec/')),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.h, 15.h, 0, 15.h),
                    child: InkWell(
                        child: Image(
                            image:
                                const AssetImage('assets/images/facebook.png'),
                            width: 35.h),
                        onTap: () => launch(
                            'https://www.facebook.com/Prowess-Agronomía-292299772568132')),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.h, 15.h, 0, 15.h),
                    child: InkWell(
                        child: Image(
                            image: const AssetImage('assets/images/tiktok.png'),
                            width: 35.h),
                        onTap: () =>
                            launch('https://www.tiktok.com/@totalprowess_ec')),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
