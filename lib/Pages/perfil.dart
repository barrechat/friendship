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
