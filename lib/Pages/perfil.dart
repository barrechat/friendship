import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friendship/Class/GlobalData.dart';
import 'package:friendship/Pages/splash.dart';
import 'package:friendship/Widgets/qr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'package:friendship/components/my_textfield.dart';
import 'package:friendship/main.dart';
class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final supabase = SupabaseClient(
      'https://peaoifidogwgoxzrpjft.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA');
  String avatar =
      "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/avatar.png";
  bool notificationEnabled = true;
  String selectedLanguage = 'English';
  String selectedLanguageAcronim = 'en';// Siempre se mostrará en inglés

  Future<void> mostrarOpciones() async {
    // Siempre se utilizará el idioma inglés
    final languageStrings =
    await rootBundle.loadString('assets/$selectedLanguageAcronim.json');
    final Map<String, dynamic> localizedStrings =
    Map<String, dynamic>.from(json.decode(languageStrings));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizedStrings['language']),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localizedStrings['select_language']),
                      Text(selectedLanguage),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(localizedStrings['select_language']),
                          content: DropdownButton<String>(
                            value: selectedLanguage,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLanguage = newValue!;
                                selectedLanguageAcronim =
                                selectedLanguage == 'English' ? 'en' : 'es';
                                GlobalData().language = selectedLanguage;
                              });
                              Navigator.pop(context);
                            },
                            items: <String>['English', 'Español']
                                .map<DropdownMenuItem<String>>(
                                  (String value) =>
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ),
                            )
                                .toList(),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(localizedStrings['accept']),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text(localizedStrings['notifications']),
                  subtitle: Text(
                      localizedStrings['enable_disable_notifications']),
                  trailing: Checkbox(
                    value: notificationEnabled,
                    onChanged: (bool? value) {
                      setState(() {
                        notificationEnabled = !notificationEnabled;
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(localizedStrings['logout']),
                  onTap: () async {
                    try {
                      LoginPage loginPageInstance =
                      LoginPage(supabase: supabase);
                      loginPageInstance.setCerrarSesion();
                      await supabase.auth.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => loginPageInstance,
                        ),
                      );
                    } on AuthException catch (error) {
                      context.showErrorSnackBar(message: error.message);
                    } catch (error) {
                      context.showErrorSnackBar(
                          message: 'Unexpected error occurred');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(localizedStrings["Perfil"]),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                mostrarOpciones();
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 150),
                  Image.network(
                    avatar,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  bool extended = false;
  double size = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              mostrarOpciones(); // Mostrar el diálogo de configuración
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Aquí puedes llamar a la función que desees al hacer clic en la imagen
                mostrarOpcionesDeAvatar();
              },
              child: Row(
                children: [
                  SizedBox(width: 150),
                  Image.network(
                    avatar,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      extended = !extended;
                      size = extended ? 200.0 : 50.0;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: extended ? 200.0 : 100.0, // Cambia el ancho al hacer clic
                    height: extended ? 200.0 : 100.0, // Cambia la altura al hacer clic
                    child: Center(
                      child: QRImage(size),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void mostrarOpcionesDeAvatar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambiar Avatar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Opción 1'),
                onTap: () {
                  cambiarAvatar('https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/avatar.png');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Opción 2'),
                onTap: () {
                  cambiarAvatar('https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/avatarmujer.png?t=2023-11-28T10%3A25%3A42.756Z');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Opción 3'),
                onTap: () {
                  cambiarAvatar('https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/helicoptero.png?t=2023-11-28T10%3A26%3A04.315Z');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para cambiar el avatar
  void cambiarAvatar(String nuevaUrlAvatar) {
    setState(() {
      avatar = nuevaUrlAvatar;
    });
  }
}