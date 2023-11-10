import 'package:flutter/material.dart';
import 'package:friendship/Class/compartir_enlace.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';


class Confirmacion extends StatefulWidget {
  @override
  ConfirmacionState createState() => ConfirmacionState();
}

class ConfirmacionState extends State<Confirmacion> {

  var amigo = UserData.username;

  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );

  Future<void> addAmigo({required BuildContext context}) async {

    //Parte de la lista de amigos del usuario que te manda la solicitud
    var listaAmigos = await supabase
        .from('usuarios')
        .select('lista_amigos')
        .eq('username','Abeldel');

    if (listaAmigos.isNotEmpty) {
      var primeraLista = listaAmigos[0];
      if (primeraLista != null) {
        var amigos = primeraLista['lista_amigos'];

        if (amigos == null) {
          amigos = [];
        }

        if (!amigos.contains(amigo)) {
          amigos.add(amigo);
        } else {
          _showPopup(context);
        }

        await supabase
            .from('usuarios')
            .update({ 'lista_amigos': amigos })
            .match({ 'username': 'Abeldel' });
      }
    }

    /* //Parte de la lista de amigos del usuario
    var listaAmigos2 = await supabase
        .from('usuarios')
        .select('lista_amigos')
        .eq('username', amigo);

    if (listaAmigos2.isNotEmpty) {
      var primeraLista2 = listaAmigos2[0];
      if (primeraLista2 != null) {
        var amigos2 = primeraLista2['lista_amigos'];

        if (amigos2 == null) {
          amigos2 = [];
        }

        if (!amigos2.contains('Abeldel')) { //Cambiar Abeldel por el usuario logueado
          amigos2.add(amigo);
        } else {
          _showPopup(context);
        }

        await supabase
            .from('usuarios')
            .update({ 'lista_amigos': amigos2 })
            .match({ 'username': amigo });
      }
    }*/
    UserData.username ='';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aceptar'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () async {
              await addAmigo(context:context);
            },
            child: Text('Aceptar'),
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadir Amigo'),
          content: Text('Este usuario ya es tu amigo'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}