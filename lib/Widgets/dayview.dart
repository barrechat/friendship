import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../Class/consultas.dart';
import '../Class/evento.dart';
import '../Class/usernameAuxiliar.dart';

class Day extends StatefulWidget {
  DayViewState get state => state;


  @override
  State<Day> createState() => DayViewState();
}

class DayViewState extends State<Day> {
   List<CalendarEventData> eventos = [];
   EventController controller = EventController();

  @override
  Widget build(BuildContext context) {


    obtenerEventos();
    return DayView(
      controller: controller,
    );
  }
   Future<void> obtenerEventos() async {
     List<Evento> eventosObtenidos = await Consultas().EventosPropios();
     List<CalendarEventData> nuevosEventos = [];

     for (var evento in eventosObtenidos) {
       if (!eventos.contains(evento)) {

         String formattedDateStringIni = evento.fechaHoraInicio.substring(0, 10) + ' ' + evento.fechaHoraInicio.substring(10);
         String formattedDateStringFin = evento.fechaHoraFin.substring(0, 10) + ' ' + evento.fechaHoraFin.substring(10);
         //print(formattedDateStringIni);
         //print(formattedDateStringFin);
         DateTime dateTimeInicio = DateTime.parse(evento.fechaHoraInicio);
         DateTime dateTimeFin = DateTime.parse(evento.fechaHoraFin);
         var nuevoEvento = CalendarEventData(
           title: evento.name,
           date: dateTimeInicio, // Usa la fecha del evento
           event: evento.name,
           description: evento.descripcion,
           startTime: dateTimeInicio, // Usa la hora de inicio del evento
           endTime: dateTimeFin, // Usa la hora de finalización del evento
         );
         nuevosEventos.add(nuevoEvento);
       }
     }

     /*setState(() {
       if(mounted) {
         eventos.addAll(nuevosEventos);
         controller.addAll(nuevosEventos);
       }
     });*/
   }


}