// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prowes_motorizado/src/bloc/singup_bloc.dart';
import 'package:prowes_motorizado/src/models/motorizado_model.dart';
import 'package:prowes_motorizado/src/services/usuario_services.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  UsuarioService singupService = UsuarioService();
  final SignUpBloc _bloc = SignUpBloc();
  bool _obscureText = true;
  int _currentStep = 0;
  final items = ['Tipo A', 'Tipo B', 'Tipo C', 'Tipo E'];
  final items2 = ['Motocicleta', 'Camion', 'Camioneta'];
  String? _valueSelected = 'Tipo A';
  String? _valueSelected2 = 'Motocicleta';

  final TextEditingController _textController = TextEditingController();
  String? _fecha;
  File? _image;
  bool _onSaving = false;
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
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
              child: Image.asset(
                'assets/images/Logo_ProwessAgronomia.png',
                width: 200,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.h, 5.h, 0, 0),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(97, 206, 112, 1),
              ),
            ),
            child: Stepper(
              physics: ClampingScrollPhysics(),
              elevation: 10.h,
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep != 3) {
                  setState(() => _currentStep++);
                }
              },
              onStepCancel: () {
                if (_currentStep != 0) {
                  setState(() => _currentStep--);
                }
              },
              onStepTapped: (index) {
                setState(() => _currentStep = index);
              },
              steps: [
                Step(
                  isActive: _currentStep >= 0,
                  title: const Text(""),
                  content: Column(
                    children: <Widget>[
                      titulo('Datos Personales'),
                      textcamp("Correo electrónico", "admin@espe.edu.ec",
                          const Icon(Icons.email_outlined), 0),
                      textcamp("Nombre y Apellido", "Brandon Lopez",
                          const Icon(Icons.person_outlined), 1),
                      textcamp("Teléfono", "0987654321",
                          const Icon(Icons.phone_android_outlined), 2),
                      textcamp("Dirección", "Guayaquil y ",
                          const Icon(Icons.location_on_outlined), 3),
                      textcamp("Número de Cedula", "0550074962",
                          const Icon(Icons.badge_outlined), 4),
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
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep >= 1,
                  title: const Text(""),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
                        child: titulo('Datos de la Vehiculo'),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.airport_shuttle_sharp,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                          Container(
                            width: 140.h,
                            margin: EdgeInsets.fromLTRB(15.h, 0, 0, 0),
                            padding: EdgeInsets.fromLTRB(10.h, 0, 8.h, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                elevation: 0,
                                value: _valueSelected2,
                                items: items2.map(buildMenuItem).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _valueSelected2 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.featured_play_list_outlined,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                          Container(
                            width: 100.h,
                            margin: EdgeInsets.fromLTRB(15.h, 0, 0, 0),
                            padding: EdgeInsets.fromLTRB(8.h, 0, 8.h, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                elevation: 0,
                                value: _valueSelected,
                                items: items.map(buildMenuItem).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _valueSelected = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        enableInteractiveSelection: false,
                        controller: _textController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_outlined),
                          labelText: "Fecha de Caducidad",
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _selectDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep >= 2,
                  title: const Text(""),
                  content: Column(
                    children: [
                      titulo('Datos del Vehículo'),
                      textcamp("Número de Placa", "XBA-2525",
                          const Icon(Icons.confirmation_num_outlined), 5),
                      textcamp("Color del Vehículo", "rojo",
                          const Icon(Icons.invert_colors_outlined), 6),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep >= 3,
                  title: const Text(""),
                  content: Column(
                    children: [
                      titulo('Datos del Perfil'),
                      Column(
                        children: <Widget>[
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
                          Column(
                            verticalDirection: VerticalDirection.down,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      pickImage(ImageSource.gallery),
                                  icon: const Icon(
                                      Icons.add_photo_alternate_outlined),
                                  label: const Text("Galeria"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      pickImage(ImageSource.camera),
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  label: const Text("Cámara"),
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder<bool>(
                            stream: _bloc.signUpValidStream,
                            builder: (context, snapshot) {
                              return _onSaving
                                  ? Container(
                                      padding: EdgeInsets.all(12.h),
                                      child: SizedBox.square(
                                        dimension: 25.h,
                                        child: const CircularProgressIndicator(
                                          color:
                                              Color.fromRGBO(97, 206, 112, 1),
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
                                              String _urlImage =
                                                  await singupService
                                                      .uploadImage(_image!);
                                              Motorizado motorizado =
                                                  Motorizado(
                                                      email: _bloc.email,
                                                      password: _bloc.password,
                                                      displayName:
                                                          _bloc.username,
                                                      telefono: _bloc.number,
                                                      direccion:
                                                          _bloc.direction,
                                                      cedula: _bloc.id,
                                                      tipoLic: _valueSelected,
                                                      caducidadLic: _fecha,
                                                      numPlaca: _bloc.placa,
                                                      colorVeh: _bloc.color,
                                                      profileImage: _urlImage,
                                                      role: _valueSelected2);
                                              int resp = await singupService
                                                  .postMotorizado(motorizado);
                                              if (resp == 201) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: const Text(
                                                        'Usuario Registrado'),
                                                    duration: const Duration(
                                                        milliseconds: 1500),
                                                    width: 280.0,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20.0,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20.0,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
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
                                        primary: const Color.fromRGBO(
                                            97, 206, 112, 1),
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  Widget titulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
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
                  : id == 3
                      ? _bloc.direcStream
                      : id == 4
                          ? _bloc.idStream
                          : id == 5
                              ? _bloc.placaStream
                              : _bloc.colorStream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: id == 0
              ? _bloc.changeEmail
              : id == 1
                  ? _bloc.changeUsername
                  : id == 2
                      ? _bloc.changeNumber
                      : id == 3
                          ? _bloc.changeDirec
                          : id == 4
                              ? _bloc.changeId
                              : id == 5
                                  ? _bloc.changePlaca
                                  : _bloc.changeColor,
          keyboardType: id == 0
              ? TextInputType.emailAddress
              : id == 2
                  ? TextInputType.number
                  : id == 4
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

  //Calendario
  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2028),
    );
    if (picked != null) {
      setState(() {
        _fecha = picked.toString();

        _textController.text =
            '${picked.day} / ${picked.month} / ${picked.year}';
      });
    }
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
