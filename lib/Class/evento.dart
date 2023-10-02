import 'type.dart';
class Evento{
  late final int id;
  late String name;
  late Type type;
  late String descripcion;
  late String precio;

  Evento(this.id, this.name, this.type, this.descripcion,this.precio);
}