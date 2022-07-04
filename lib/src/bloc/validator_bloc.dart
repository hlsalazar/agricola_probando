import 'dart:async';

class Validator {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Correo no válido');
      }
    },
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 7) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Contraseña al menos 7 caracteres');
      }
    },
  );

  final usernameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 8) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Este campo requiere al menos 8 caracteres');
      }
    },
  );

  final numberValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 10) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Este campo requiere al menos 10 caracteres');
      }
    },
  );

  final direcValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 5) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Este campo requiere al menos 5 caracteres');
      }
    },
  );

  final idValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 10) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Este campo requiere al menos 10 caracteres');
      }
    },
  );

  final placaValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 5) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Este campo requiere al menos 5 caracteres');
      }
    },
  );
  final colorValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 4) {
        sink.add(data); //La validación se cumplió
      } else {
        sink.addError('Este campo requiere al menos 4 caracteres');
      }
    },
  );
}
