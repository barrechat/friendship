import 'package:flutter/material.dart';
import 'package:friendship/Class/consultas.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'package:friendship/Widgets/listEventoBusqueda.dart';
import 'package:friendship/Class/type.dart';
class RecomendacionPage extends StatelessWidget {

  const RecomendacionPage({super.key});

  // You can perform your search logic here based on the searchTerm

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
        child: Text("Prueba"),
        onPressed: () {
          Consultas consultas = Consultas();
          consultas.EventosAmigos();
        }
        ,)
      ,);
  }
}