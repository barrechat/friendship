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

  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );

  bool added = false;

  Future<void> addAmigo({required BuildContext context}) async {

    var amigo = UserData.username;
    var usuarioActual = UserData.usuarioLog!.username;

    //print(usuarioActual);
    //print(amigo);

    //Parte de la lista de amigos del usuario actual
    var listaAmigos = await supabase
        .from('usuarios')
        .select('lista_amigos')
        .eq('username',usuarioActual);

    if (listaAmigos.isNotEmpty) {
      var primeraLista = listaAmigos[0];
      if (primeraLista != null) {
        var amigos = primeraLista['lista_amigos'];

        if (amigos == null) {
          amigos = [];
        }

        if (!amigos.contains(amigo)) {
          amigos.add(amigo);
          added = true;
        } else {
          _showPopup(context, 'Error', 'El usuario y tú ya erais amigos');
        }

        await supabase
            .from('usuarios')
            .update({ 'lista_amigos': amigos })
            .match({ 'username': usuarioActual });
      }
    }

     //Parte de la lista de amigos del usuario que manda la solicitud
    var listaAmigos2 = await supabase
        .from('usuarios')
        .select('lista_amigos')
        .eq('username',amigo);

    if (listaAmigos2.isNotEmpty) {
      var primeraLista = listaAmigos2[0];
      if (primeraLista != null) {
        var amigos = primeraLista['lista_amigos'];

        if (amigos == null) {
          amigos = [];
        }

        if (!amigos.contains(usuarioActual)) {
          amigos.add(usuarioActual);
        } else {
          _showPopup(context, 'Error', 'El usuario y tú ya erais amigos');
        }

        await supabase
            .from('usuarios')
            .update({ 'lista_amigos': amigos })
            .match({ 'username': amigo });
      }
    }
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
              if(added){
                added = false;
                _showPopup(context, 'Amigo añadido', 'El usuario y tú ahora sois amigos');
              }
            },
            child: Text('Aceptar'),
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context,String titulo, String texto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(texto),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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