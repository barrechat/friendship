import 'package:calendar_view/calendar_view.dart';

import 'type.dart';
import 'package:friendship/Class/filtro.dart';

class Evento {
  late final int id;
  late String name;
  late Type type;
  late String descripcion;
  late String precio;
  late List<Filtro> filtros;
  late String fechaHoraInicio;
  late String fechaHoraFin;
  Evento(this.id, this.name, this.type, this.descripcion, this.precio,
      this.filtros, this.fechaHoraInicio, this.fechaHoraFin);

  static List<CalendarEventData> convertirEventos(List<Evento> ListaEventos){
    List<CalendarEventData> nuevosEventos = [];

    for (var evento in ListaEventos) {
        String formattedDateStringIni = evento.fechaHoraInicio.substring(0, 10) + ' ' + evento.fechaHoraInicio.substring(10);
        String formattedDateStringFin = evento.fechaHoraFin.substring(0, 10) + ' ' + evento.fechaHoraFin.substring(10);
        DateTime dateTimeInicio = DateTime.parse(evento.fechaHoraInicio);
        DateTime dateTimeFin = DateTime.parse(evento.fechaHoraFin);
        var nuevoEvento = CalendarEventData(
          title: evento.name,
          date: dateTimeInicio,
          event: evento.name,
          description: evento.descripcion,
          startTime: dateTimeInicio,
          endTime: dateTimeFin,
        );
        nuevosEventos.add(nuevoEvento);
      }
    return nuevosEventos;
    }

  }

