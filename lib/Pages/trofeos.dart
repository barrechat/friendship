import 'package:flutter/material.dart';

class Trofeos extends StatefulWidget {
  @override
  TrofeosState createState() => TrofeosState();
}

class TrofeosState extends State<Trofeos> {

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
                onPressed: () {

                },
                child: Text('Compartir con contacto'),
              ),
              SizedBox(height: 16), // Espacio entre los botones
              ElevatedButton(
                onPressed: () {

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