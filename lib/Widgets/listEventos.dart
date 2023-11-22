import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Widgets/eventoWidget.dart';

class ListEventos extends StatelessWidget {
  final List<Evento> eventos;

  const ListEventos({super.key, required this.eventos});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            return EventoWidget(evento: eventos[index]);
          }),
    );
  }
}
