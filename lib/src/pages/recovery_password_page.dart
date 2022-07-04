//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prowes_motorizado/src/bloc/login_bloc.dart';
import 'package:prowes_motorizado/src/services/usuario_services.dart';
import 'package:url_launcher/url_launcher.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final LoginBloc _recoveryPasswordBloc = LoginBloc();
  bool _onSaving = false;
  final UsuarioService _usuarioService = UsuarioService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 20.h,
          tooltip: 'Regresar',
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 100.h),
            margin: EdgeInsets.all(18.h),
            child: Column(
              children: [
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
                    'Recupera tu Contraseña',
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
                    children: [
                      StreamBuilder<String>(
                        stream: _recoveryPasswordBloc.emailStream,
                        builder: (context, snapshot) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(97, 206, 112, 1),
                              ),
                            ),
                            child: TextField(
                              onChanged: _recoveryPasswordBloc.changeEmail,
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 18.h),
                        child: StreamBuilder<bool>(
                          stream:
                              _recoveryPasswordBloc.formRecoveryPasswordtream,
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
                                            Map<String, dynamic> resp =
                                                await _usuarioService
                                                    .resetPassword(
                                                        _recoveryPasswordBloc
                                                            .email);

                                            if (resp.containsKey("link")) {
                                              _printAlert(resp["link"]);
                                            } else if (resp
                                                .containsKey("message")) {
                                              var snackBar = const SnackBar(
                                                content: Text(
                                                    'Correo incorrecto, intentelo mas tarde...'),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          const Color.fromRGBO(97, 206, 112, 1),
                                      elevation: 15.h,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.h)),
                                    ),
                                    child: Text(
                                      'Recuperar',
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _printAlert(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Link Generado'),
        content: const Text(
            'Para continuar con el proceso presione en Aceptar, si desea finalizar el proceso presione en Cancelar\n\nNota: Recuerda que tu contraseña debe tener al menos 7 caracteres'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
              Navigator.pop(context, 'Cancelar');
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              launch(message);
              Navigator.pop(context, 'Aceptar');
              Navigator.pop(context, 'Aceptar');
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
