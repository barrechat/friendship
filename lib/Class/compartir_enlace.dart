import 'package:flutter/material.dart';
import 'package:friendship/components/my_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'dart:io';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:friendship/Pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompEnlace extends StatefulWidget {
  @override
  CompEnlaceState createState() => CompEnlaceState();
}

class CompEnlaceState extends State<CompEnlace> {
  var telefono = '';

  final supabase = SupabaseClient(
     'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );


  void launchWhatsApp({required String phone}) async {
    String nombreUsuario = UserData.usuarioLogueado!;
    String numeroSinPais = phone;

    final Uri whatsappUrl = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: numeroSinPais,
      queryParameters: {'text': 'https://aplicacionpin.000webhostapp.com/redireccion.html?username='+nombreUsuario},
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch';
    }

  }

  String quitarEspaciosEnBlanco(String cadena) {
    return cadena.replaceAll(' ', ''); // Reemplaza los espacios en blanco por una cadena vacía.
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compartir con contacto'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  print(UserData.usuarioLogueado);
                  final granted = await FlutterContactPicker.requestPermission();

                  final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                  telefono = contact!.phoneNumber!.number.toString();

                  telefono = quitarEspaciosEnBlanco(telefono);

                  launchWhatsApp(phone: telefono);
                },
                child: Text('Compartir con contacto'),
              ),
              SizedBox(height: 16), // Espacio entre los botones
              ElevatedButton(
                onPressed: () async {
                  try {
                    await supabase.auth.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage(supabase: supabase)),
                    );
                  } on AuthException catch (error) {
                    context.showErrorSnackBar(message: error.message);
                  } catch (error) {
                    context.showErrorSnackBar(message: 'Unexpected error occurred');
                  }
                },
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}