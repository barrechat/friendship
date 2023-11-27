import 'type.dart';
import 'package:friendship/Class/filtro.dart';

class EventoDiario {
  late final int id;
  late String name;
  late Type type;
  late String descripcion;
  late String precio;
  late List<Filtro> filtros;
  late String fechaHoraInicio;
  late String fechaHoraFin;
  EventoDiario(this.id, this.name, this.type, this.descripcion, this.precio,
      this.filtros, this.fechaHoraInicio, this.fechaHoraFin);
}
