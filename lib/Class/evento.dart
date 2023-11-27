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
}
