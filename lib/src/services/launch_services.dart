import 'package:url_launcher/url_launcher.dart';

launchURL() async {
  const url = "https://wa.me/+593998160293";
  _launch(url);
}

lauchCorreoElectronico() async {
  final Uri _correoElectronico = Uri(
    scheme: 'mailto',
    path: 'prowessagronomia@gmail.com',
  );

  _launch(_correoElectronico.toString());
}

launchLlamada() async {
  const numeroTelefonico = "tel:+593998160293";
  _launch(numeroTelefonico);
}

launchPhone(String number) async {
  var numeroTelefonico = "tel:$number";
  _launch(numeroTelefonico);
}

launchWhatsApp(String number) async {
  var url = "https://wa.me/593$number";
  _launch(url);
}

_launch(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se encuentra el URL: $url';
  }
}
