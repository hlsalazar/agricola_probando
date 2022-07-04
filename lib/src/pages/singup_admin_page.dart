import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prowes_motorizado/src/bloc/singup_bloc.dart';
import 'package:prowes_motorizado/src/models/admin_model.dart';
import 'package:prowes_motorizado/src/services/admin_services.dart';

class SingupAdmin extends StatefulWidget {
  const SingupAdmin({Key? key}) : super(key: key);

  @override
  State<SingupAdmin> createState() => _SingupAdminState();
}

class _SingupAdminState extends State<SingupAdmin> {
  final SignUpBloc _bloc = SignUpBloc();
  bool _obscureText = true;
  bool _onSaving = false;
  File? _image;
  AdminServices adminServices = AdminServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
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
                'Registrar Administradores',
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
                  textcamp(
                    'Correo electrónico',
                    'admin@espe.edu.ec',
                    const Icon(Icons.email_outlined),
                    0,
                  ),
                  textcamp(
                    "Nombre y Apellido",
                    "Brandon Lopez",
                    const Icon(Icons.person_outlined),
                    1,
                  ),
                  textcamp(
                    "Teléfono",
                    "0987654321",
                    const Icon(Icons.phone_android_outlined),
                    2,
                  ),
                  textcamp(
                    "Número de Cedula",
                    "0550074962",
                    const Icon(Icons.badge_outlined),
                    3,
                  ),
                  StreamBuilder<Object>(
                    stream: _bloc.passwordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: _bloc.changePassword,
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
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                  const Text(
                    'Foto de perfil',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ),
                  Center(
                    child: _image == null
                        ? const Icon(Icons.add_photo_alternate_outlined,
                            size: 100.0)
                        : Image.file(
                            _image!,
                            width: 100,
                            height: 100,
                          ),
                  ),
                  Row(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
                        child: ElevatedButton.icon(
                          onPressed: () => pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          label: const Text("Galeria"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                        child: ElevatedButton.icon(
                          onPressed: () => pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: const Text("Cámara"),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: StreamBuilder<bool>(
                      stream: _bloc.signUpAdminValidStream,
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
                                        String _urlImage = await adminServices
                                            .uploadImage(_image!);
                                        Admin administrador = Admin(
                                            email: _bloc.email,
                                            password: _bloc.password,
                                            displayName: _bloc.username,
                                            telefono: _bloc.number,
                                            cedula: _bloc.id,
                                            profileImage: _urlImage,
                                            role: 'Administrador');
                                        int resp = await adminServices
                                            .postAdmid(administrador);
                                        if (resp == 201) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'Usuario Registrado'),
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              width: 280.0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)), // Inner padding for SnackBar content.
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'ERROR.. Al Registrar Intentelo mas tarde'),
                                              duration: const Duration(
                                                  milliseconds: 1500),
                                              width: 280.0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)), // Inner padding for SnackBar content.
                                            ),
                                          );
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
                                  'Registrarse',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget textcamp(String label, String hint, Icon icon, int id) {
    return StreamBuilder<String>(
      stream: id == 0
          ? _bloc.emailStream
          : id == 1
              ? _bloc.usernameStream
              : id == 2
                  ? _bloc.numberStream
                  : _bloc.idStream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: id == 0
              ? _bloc.changeEmail
              : id == 1
                  ? _bloc.changeUsername
                  : id == 2
                      ? _bloc.changeNumber
                      : _bloc.changeId,
          keyboardType: id == 0
              ? TextInputType.emailAddress
              : id == 2
                  ? TextInputType.number
                  : TextInputType.text,
          controller: null,
          decoration: InputDecoration(
            errorText: snapshot.error?.toString(),
            icon: icon,
            labelText: label,
            hintText: hint,
          ),
        );
      },
    );
  }

  Future pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Imagen seleccionado correctamente',
            style: TextStyle(fontSize: 20),
          ),
          duration: const Duration(milliseconds: 1500),
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
    } else {
      _image = null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'No se selecciono ninguna imagen',
            style: TextStyle(fontSize: 20),
          ),
          duration: const Duration(milliseconds: 1500),
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
    setState(() {});
  }
}
