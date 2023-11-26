import 'package:flutter/material.dart';

class Trofeos extends StatefulWidget {
  @override
  TrofeosState createState() => TrofeosState();
}

class TrofeosState extends State<Trofeos> {

  final String trofeoImagen = "https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/avatares/trofeo.png?t=2023-11-26T17%3A45%3A04.380Z";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trofeos"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Image.network(
          trofeoImagen,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}