import 'dart:io';

import 'package:flutter/material.dart';
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
  final supabase = SupabaseClient('https://peaoifidogwgoxzrpjft.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA');
  // Nombre del bucket y archivo que deseas obtener
  final String avatar = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/avatar.png";
  bool notificationEnabled = true;
  String selectedLanguage = 'Español';

  final String trofeo1Imagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo.png?t=2023-11-26T17%3A45%3A04.380Z";
  final String trofeo25Imagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo25.png?t=2023-11-26T19%3A01%3A34.675Z";
  final String trofeo50Imagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo50.png?t=2023-11-26T19%3A05%3A48.647Z";
  final String noTrofeoImagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/noTrofeo.png?t=2023-11-26T18%3A17%3A57.454Z";

  final int eventosUsuario = 52;
  var trofeo1 = '';
  var trofeo2 = '';
  var trofeo3 = '';
  var telefono = '';

  void mostrarTrofeos(int eventosCreados){
    if(eventosCreados >= 1){trofeo1=trofeo1Imagen;}else{trofeo1=noTrofeoImagen;}
    if(eventosCreados >= 25){trofeo2=trofeo25Imagen;}else{trofeo2=noTrofeoImagen;}
    if(eventosCreados >= 50){trofeo3=trofeo50Imagen;}else{trofeo3=noTrofeoImagen;}
  }

  @override
  void initState() {
    super.initState();
    mostrarTrofeos(eventosUsuario);
  }

  void mostrarOpciones() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Configuraciones'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Contenido de la ventana emergente (ajustes, idioma, notificaciones, etc.)
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Idioma'),
                      Text(selectedLanguage), // Muestra el idioma seleccionado
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Seleccionar idioma'),
                          content: DropdownButton<String>(
                            value: selectedLanguage,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLanguage = newValue!;
                              });
                              Navigator.pop(context); // Cierra el diálogo al cambiar el idioma
                            },
                            items: <String>['Español', 'Inglés'] // Opciones de idioma
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Aceptar'),
                              onPressed: () {
                                // Acción para el idioma seleccionado
                                // ...
                                Navigator.pop(context); // Cierra el diálogo
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text('Notificaciones'),
                  subtitle: Text('Activar/desactivar notificaciones'),
                  trailing: Checkbox(
                    value: notificationEnabled,
                    onChanged: (bool? value) {
                      setState(() {
                        notificationEnabled = !notificationEnabled;
                        Navigator.pop(context);
                        // Aquí puedes incluir la lógica para activar o desactivar las notificaciones
                        // Por ejemplo, invocar métodos del plugin de notificaciones
                        // Para simplicidad, aquí solo se actualiza el estado de la casilla
                      });
                    },

                  ),
                ),
                ListTile(
                  key:Key("cerrar-sesion"),
                  title: Text('Cerrar sesión'),
                  onTap: () async {
                      try {
                        LoginPage loginPageInstance = new LoginPage(supabase: supabase);
                        loginPageInstance.setCerrarSesion();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => loginPageInstance),
                        );
                      } on AuthException catch (error) {
                        context.showErrorSnackBar(message: error.message);
                      } catch (error) {
                        context.showErrorSnackBar(message: 'Unexpected error occurred');
                      }
                    }, // Cierra el diálogo
                  // },
                ),
              ],
            ),
          ),
        );
      },
    );
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
            key:Key("ajustes"),
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
            Row(
              children: [
                SizedBox(width: 150),
                Image.network(
                  key:Key("avatar"),
                  avatar,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                    key : Key("opcion-qr"),
                    onTap: () {
                      _mostrarPopup(context);
                    },
                    child: QRImage(50)
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          trofeo1,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 20),
                        Text('1 evento'),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          trofeo2,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 20),
                        Text('25 eventos'),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          key:Key("copa-del-mundo"),
                          trofeo3,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 20),
                        Text('50 eventos'),
                      ],
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

  void _mostrarPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key : Key("popup-qr"),
          content: Container(
            width: 300.0, // Establecer un ancho específico para el AlertDialog
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QRImage(200),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Acción a realizar cuando se hace clic en el botón
                    Navigator.of(context).pop(); // Cierra el popup
                  },
                  child: Text('Cerrar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
