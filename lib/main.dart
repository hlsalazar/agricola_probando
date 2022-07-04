import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:prowes_motorizado/src/pages/home_page.dart';
import 'package:prowes_motorizado/src/pages/login_page.dart';
import 'package:prowes_motorizado/src/pages/no_internet_page.dart';
import 'package:prowes_motorizado/src/pages/singup_page.dart';
import 'package:prowes_motorizado/src/provider/connectivity_provider.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';
import 'package:prowes_motorizado/src/theme/theme.dart';
import 'package:prowes_motorizado/src/pages/admin_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then(
    (value) {
      runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider())
      ], child: const MyApp()));
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: true);
    final mainProvider = Provider.of<MainProvider>(context, listen: true);

    return FutureBuilder(
      future: connectivityProvider.startMonitoring(),
      builder: (context, snapshot) {
        return FutureBuilder<void>(
          future: mainProvider.initPrefs(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const SizedBox.square(
                  dimension: 150.0, child: Text("Ha ocurrido un error"));
            }

            if (snapshot.hasData) {
              return ScreenUtilInit(
                designSize: const Size(360, 690),
                builder: () => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Prowess Agronomía',
                  theme: AppTheme.themeData(mainProvider.mode),
                  routes: {
                    "/noInternet": (context) => const NoInternet(),
                    "/login": (context) => const LoginPage(),
                    "/signup": (context) => const SingUpPage()
                  },
                  home: connectivityProvider.isOnline
                      ? mainProvider.token == ""
                          ? const LoginPage()
                          : JwtDecoder.isExpired(mainProvider.token)
                              ? const LoginPage()
                              : JwtDecoder.decode(mainProvider.token)["role"] ==
                                      "Administrador"
                                  ? const AdminPage()
                                  : const HomePage()
                      : const NoInternet(),
                ),
              );
            }

            return const SizedBox.square(
                dimension: 50.0, child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
