import 'dart:io';

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
     Color colorCalendario;
     Color colorYo = Color(0xFF5094F9);

     Color colorAmigo = Color(0xFF20BD8E);

     for (var evento in eventosObtenidos) {
       if (!eventos.contains(evento)) {

         String formattedDateStringIni = evento.fechaHoraInicio.substring(0, 10) + ' ' + evento.fechaHoraInicio.substring(10);
         String formattedDateStringFin = evento.fechaHoraFin.substring(0, 10) + ' ' + evento.fechaHoraFin.substring(10);
         //print(formattedDateStringIni);
         //print(formattedDateStringFin);
         DateTime dateTimeInicio = DateTime.parse(evento.fechaHoraInicio);
         DateTime dateTimeFin = DateTime.parse(evento.fechaHoraFin);
         if (evento.userName == UserData.usuarioLog?.username) {
           // Asigna una decoración específica para este filtro
           colorCalendario = colorYo;
         }else {
           // Asigna una decoración predeterminada o por defecto
           colorCalendario = colorAmigo;
         }


         var nuevoEvento = CalendarEventData(
           title: evento.name,
           date: dateTimeInicio, // Usa la fecha del evento
           event: evento.name,
           description: evento.descripcion,
           startTime: dateTimeInicio, // Usa la hora de inicio del evento
           endTime: dateTimeFin, // Usa la hora de finalización del evento
           color: colorCalendario,
         );
         nuevosEventos.add(nuevoEvento);
       }
     }

     setState(() {
       eventos.addAll(nuevosEventos);
       controller.addAll(nuevosEventos);
     });
   }


}