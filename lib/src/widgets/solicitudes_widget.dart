import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NosotrosWidget extends StatelessWidget {
  const NosotrosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 325.h,
                height: 50.h,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.asset('assets/images/delivery-truck.png')),
                    const SizedBox(width: 30),
                    const Text(
                      "Solicitudes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 175.h,
            width: 150.h,
          ),
        ],
      ),
    );
  }
}
