import 'package:flutter_test/flutter_test.dart';
import 'package:friendship/Class/consultas.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'package:friendship/Class/grupo-amigos.dart';
import 'package:friendship/Class/type.dart';
import 'package:friendship/Class/user.dart';
void main() {
  group("smoke tests clases", () {
    test('Smoke test Consulta', () {
     Consultas consultor = Consultas();
    });
    test('Smoke test Evento', () {
      Type tipo = Type(1,"tipo");
      Filtro filtro = Filtro(1,"filtro");
      List<Filtro> filtros = [filtro,filtro];
      Evento evento = Evento(1, "hola", tipo, "descripcion", "precio", filtros, DateTime.now().toString(), DateTime.now().toString());
    });
    test('Smoke test Tipo', () {
      Type tipo = Type(1,"tipo");
    });
    test('Smoke test filtro', () {
      Filtro filtro = Filtro(1,"filtro");
    });
    test('Smoke test User', () {
      User user = User("user","user@gmail.com",634885181,12);
    });
    test('Smoke test GrupoAmigos', () {
      User user = User("user","user@gmail.com",634885181,12);
      List<User> amigos = [user,user];
      GrupoAmigos grupo = GrupoAmigos(1,"grupito",amigos);
    });
  });
}