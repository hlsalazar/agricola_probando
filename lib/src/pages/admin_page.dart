import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/widgets/admin_widget.dart';
import 'package:prowes_motorizado/src/widgets/transporte_widget.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late PageController _pageController = PageController();
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() => selectedIndex = index);
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        elevation: 10.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo_ProwessAgronomia.png',
              fit: BoxFit.contain,
              height: 150.h,
              width: 150.h,
            ),
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _listOfWidget,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: onButtonPressed,
        iconSize: 32.h,
        activeColor: const Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(icon: Icons.person_outline, title: 'Perfil'),
          BarItem(icon: Icons.car_rental_outlined, title: 'Transporte'),
        ],
      ),
    );
  }
}

List<Widget> _listOfWidget = <Widget>[
  const AdminWidget(),
  const TransporteWidget(),
];
