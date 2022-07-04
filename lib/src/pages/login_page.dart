import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:prowes_motorizado/src/bloc/login_bloc.dart';
import 'package:prowes_motorizado/src/models/motorizado_model.dart';
import 'package:prowes_motorizado/src/pages/recovery_password_page.dart';
import 'package:prowes_motorizado/src/pages/singup_page.dart';
import 'package:prowes_motorizado/src/provider/main_provider.dart';
import 'package:prowes_motorizado/src/services/usuario_services.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final LoginBloc _loginBloc = LoginBloc();
  bool _onSaving = false;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            margin: EdgeInsets.all(12.h),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Center(
                    child: Image.asset(
                      'assets/images/Logo_ProwessAgronomia.png',
                      width: 200.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.h,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder<String>(
                        stream: _loginBloc.emailStream,
                        builder: (context, snapshot) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(97, 206, 112, 1),
                              ),
                            ),
                            child: TextField(
                              onChanged: _loginBloc.changeEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                errorText: snapshot.error?.toString(),
                                icon: const Icon(Icons.email_outlined),
                                labelText: "Correo electrónico",
                                hintText: "admin@espe.edu.ec",
                              ),
                            ),
                          );
                        },
                      ),
                      StreamBuilder<Object>(
                        stream: _loginBloc.passwordStream,
                        builder: (context, snapshot) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(97, 206, 112, 1),
                              ),
                            ),
                            child: TextField(
                              onChanged: _loginBloc.changePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                errorText: snapshot.error?.toString(),
                                icon: const Icon(Icons.lock_outline),
                                labelText: "Contraseña",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureText = !_obscureText;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.h),
                  child: StreamBuilder<bool>(
                    stream: _loginBloc.formLoginStream,
                    builder: (context, snapshot) {
                      return _onSaving
                          ? Container(
                              padding: EdgeInsets.all(12.h),
                              child: SizedBox.square(
                                dimension: 25.h,
                                child: const CircularProgressIndicator(
                                  color: Color.fromRGBO(97, 206, 112, 1),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: snapshot.hasData
                                  ? () async {
                                      setState(() => _onSaving = true);
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      setState(() => _onSaving = false);
                                      final usrSrv = UsuarioService();
                                      final usr = Motorizado(
                                          //Modelo
                                          email: _loginBloc.email,
                                          password: _loginBloc.password);

                                      Map<String, dynamic> resp =
                                          await usrSrv.login(usr);

                                      if (resp.containsKey("idToken")) {
                                        mainProvider.token = resp['idToken'];
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'Usuario y/o Contraseña incorrectos...',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            duration: const Duration(
                                                milliseconds: 1500),
                                            width: 300.0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0,
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10.0)), // Inner padding for SnackBar content.
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(97, 206, 112, 1),
                                elevation: 15.h,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.h)),
                              ),
                              child: Text(
                                'Ingresar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.h,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RecoveryPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("¿Eres nuevo?",
                          style:
                              TextStyle(color: Color.fromRGBO(0, 0, 0, 0.38))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SingUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Regístrese",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                    child: Text(
                      "Ayuda",
                      style: TextStyle(
                          fontSize: 18.h, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => launch('https://prowessagrec.com/ayuda-2/')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
