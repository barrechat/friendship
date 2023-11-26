import 'package:flutter/material.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:friendship/Class/compartir_enlace.dart';

class Trofeos extends StatefulWidget {
  @override
  TrofeosState createState() => TrofeosState();
}

class TrofeosState extends State<Trofeos> {

  final String trofeo1Imagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo.png?t=2023-11-26T17%3A45%3A04.380Z";
  final String trofeo25Imagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo25.png?t=2023-11-26T19%3A01%3A34.675Z";
  final String trofeo50Imagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo50.png?t=2023-11-26T19%3A05%3A48.647Z";
  final String noTrofeoImagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/noTrofeo.png?t=2023-11-26T18%3A17%3A57.454Z";

  final int eventosUsuario = UserData.usuarioLog!.eventosCreados;
  var trofeo1 = '';
  var trofeo2 = '';
  var trofeo3 = '';

  @override
  void initState() {
    super.initState();
    mostrarTrofeos(eventosUsuario);
  }

  void mostrarTrofeos(int eventosCreados){
    if(eventosCreados >= 1){trofeo1=trofeo1Imagen;}else{trofeo1=noTrofeoImagen;}
    if(eventosCreados >= 25){trofeo2=trofeo25Imagen;}else{trofeo2=noTrofeoImagen;}
    if(eventosCreados >= 50){trofeo3=trofeo50Imagen;}else{trofeo3=noTrofeoImagen;}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Trofeos"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => CompEnlace()),
            );
          },
        ),
      ),
      body: Center(
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
    );
  }
}