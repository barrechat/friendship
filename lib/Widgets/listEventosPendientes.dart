import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Widgets/eventoWidget.dart';

class ListEventosPendientes extends StatelessWidget {
  final List<Evento> eventos;

  const ListEventosPendientes({super.key, required this.eventos});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            return EventoWidget(evento: eventos[index]);
          }),
    );
  }
}
