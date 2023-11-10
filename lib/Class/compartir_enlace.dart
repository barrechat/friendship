import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'dart:io';
import 'package:friendship/Class/pantalla_confirmacion.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:uni_links/uni_links.dart';

class CompEnlace extends StatefulWidget {
  @override
  CompEnlaceState createState() => CompEnlaceState();
}

class CompEnlaceState extends State<CompEnlace> {
  var telefono = '';

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  void launchWhatsApp({required String phone}) async {
    String url() {
      String nombreUsuario = 'Aritz'; //Aqui se sustituye por el nombre del usuario logueado
      String numeroConPais = '+34'+ phone.toString();
      final Uri message = Uri.parse('https://aplicacionpin.000webhostapp.com/redireccion.html?username='+nombreUsuario);

      if (Platform.isAndroid) {
        return "whatsapp://send?phone=$numeroConPais&text=$message";
      } else {
        return "whatsapp://send?phone=$numeroConPais&text=$message";
      }
    }

    final Uri whatsappUrl = Uri.parse(url().toString());

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch ${url()}';
    }

  }

  String quitarEspaciosEnBlanco(String cadena) {
    return cadena.replaceAll(' ', ''); // Reemplaza los espacios en blanco por una cadena vacía.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compartir con contacto'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                final granted = await FlutterContactPicker.requestPermission();

                final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                telefono = contact!.phoneNumber!.number.toString();

                telefono = quitarEspaciosEnBlanco(telefono);

                launchWhatsApp(phone: telefono);
              },
              child: Text('Compartir con contacto'),
            ),
        ),
      ),
    );
  }

  void initUniLinks() async {
    // Maneja los enlaces profundos cuando la aplicación se inicia
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      handleDeepLink(initialLink); // Convierte la cadena a un objeto Uri
    }

    // Escucha enlaces profundos en tiempo real
    linkStream.listen((String? link) {
      handleDeepLink(link); // Pasa la cadena directamente
    });
  }

  void handleDeepLink(String? link) {
    print('handleDeepLink: $link');
    if (link != null) {
      final uri = Uri.parse(link);
      if (link.contains('miapp://pantalla_confirmacion')) {
        final username = uri.queryParameters['username'];
        if (username != null) {
          UserData.username = username;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Confirmacion(),
          ));
        }
      }
    }
  }

}