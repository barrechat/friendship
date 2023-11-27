import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../Class/consultas.dart';
import '../Class/evento.dart';
import '../Class/usernameAuxiliar.dart';

class Day extends StatefulWidget {

  @override
  State<Day> createState() => _DayViewState();
}

class _DayViewState extends State<Day> {
  late List<CalendarEventData> eventos;
   EventController controller = EventController();

  @override
  Widget build(BuildContext context) {



    return DayView(
      controller: controller,
    );
  }
  Future<void> obtenerEventos() async {
    List<Evento> eventosObtenidos = await Consultas().EventosPropios();

    List<CalendarEventData> eventosData = eventosObtenidos.map((evento) {
      if(!eventos.contains(evento)){}
      return CalendarEventData(
        title: evento.name,
        date: DateTime.now(), // Usa la fecha del evento
        event: evento.name,
        description: evento.descripcion,
        startTime: DateTime.now(), // Usa la hora de inicio del evento
        endTime: DateTime.now().add(Duration(hours: 3)), // Usa la hora de finalización del evento
      );
    }).toList();
    setState(() {
      eventos = eventosData;
      controller.addAll(eventos);
    });
  }


}