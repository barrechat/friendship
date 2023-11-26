import 'package:flutter/material.dart';
import 'package:friendship/Class/consultas.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'package:friendship/Widgets/eventoWidget.dart';
import 'package:friendship/Widgets/listEventoBusqueda.dart';
import 'package:friendship/Class/type.dart';

import '../Widgets/listEventos.dart';
class RecomendacionPage extends StatelessWidget {

  const RecomendacionPage({super.key});

  // You can perform your search logic here based on the searchTerm

  @override
  Widget build(BuildContext context) {

    return  FutureBuilder<List<Evento>>(
      future: Consultas().Recomendaciones(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Evento> eventos = snapshot.data ?? [];
          return Center(
            child: EventosWidget(eventos: eventos),
          );
        }
      },
    );
  }
}