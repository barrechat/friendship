import 'dart:ui';

import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'type.dart';

class Consultas{
  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );

  Future<List<Evento>> BuscarEventos({required String nombreEvento}) async
  {
    var response = await  supabase.from('eventos')
      .select('*')
      .eq("tipo", "publico")
      .gte("fechainicio", DateTime.now())
      .ilike("nombre", '$nombreEvento%');
    List<Evento> eventos = [];
    for (var item in response) {
      print(item);
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros));
  }
    return eventos;

  }
  Future<List<Evento>> EventosAmigos() async
  {
    List<Evento> eventos = [];
    final username =UserData.usuarioLog?.username;
    var response = await  supabase.from('usuarios')
        .select('*')
        .eq("username", username);

    for (var amigo in response[0]["lista_amigos"]) {
      var rowAmigo = await  supabase.from('eventos')
          .select('*')
          .gte("fechainicio", DateTime.now())
          .eq("usuario", amigo)
          .eq("tipo", "publico");
      for(var evento in rowAmigo){
        print(rowAmigo);
        List<Filtro> filtros = [Filtro(1, evento["filtro"]), Filtro(2, evento["filtro2"])];
        Type tipo = Type(1, evento["tipo"]);
        eventos.add(Evento(evento["id"], evento["nombre"], tipo , evento["descripcion"], "0", filtros));
      }
    }
    return eventos;

  }

  Future<List<Evento>> EventosRecomendados({required String nombreEvento}) async
  {
    var response = await  supabase.from('eventos')
        .select('*')
        .eq("tipo", "publico")
        .gte("fechainicio", DateTime.now());
    List<Evento> eventos = [];
    for (var item in response) {
      print(item);
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros));
    }
    return eventos;

  }
  Future<List<Evento>> EventosFiltro({required String filtro1, required String filtro2}) async
  {
    var response = await  supabase.from('eventos')
        .select('*')
        .eq("tipo", "publico")
        .gte("fechainicio", DateTime.now());
    List<Evento> eventos = [];
    for (var item in response) {
      print(item);
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros));
    }
    return eventos;

  }
}