import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Widgets/eventoWidget.dart';

class EventosPendientesWidget extends StatelessWidget {
  final List<Evento> eventos;

  const EventosPendientesWidget({super.key, required this.eventos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 242,
      child: ListView.builder(

          itemCount: eventos.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                EventoWidget(evento: eventos[index]),
                const SizedBox(height: 20), // Espacio entre elementos
              ],
            );
          }),
    );
  }
}
