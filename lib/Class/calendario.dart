import 'user.dart';
import 'evento.dart';
class Calendario{

  late final id;
  late final User user;
  late List<Evento> events;

  Calendario(this.id, this.user, this.events);

}