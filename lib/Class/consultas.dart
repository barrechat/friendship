import 'dart:math';
import 'dart:ui';

import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:permission_handler/permission_handler.dart';
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
      //print(item);
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
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
        //print(rowAmigo);
        List<Filtro> filtros = [Filtro(1, evento["filtro"]), Filtro(2, evento["filtro2"])];
        Type tipo = Type(1, evento["tipo"]);
        eventos.add(Evento(evento["id"], evento["nombre"], tipo , evento["descripcion"], "0", filtros, evento["fechainicio"]+" "+ evento["horainicio"],evento["fechafin"]+" "+ evento["horafin"],evento["lugar"],evento["usuario"] ));
      }
    }
    return eventos;

  }

  Future<List<Evento>> EventosRecomendados() async
  {
    List<Evento> eventos = [];
    var response = await  supabase.from('eventos')
        .select('*')
        .eq("tipo", "publico")
        .gte("fechainicio", DateTime.now())
    ;

    for (var item in response) {
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
    }

    var response2 = await  supabase.from('eventos')
        .select('*')
        .eq("lugar", "Valencia")
        .neq("usuario", UserData.usuarioLog?.username)
    ;
    for (var item in response2) {
      List<Filtro> filtros2 = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo2 = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo2 , item["descripcion"], "0", filtros2, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"], item["lugar"],item["usuario"] ));
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
      if(item["filtro1"] == filtro1 || item["filtro2"] == filtro1 || item["filtro1"] == filtro2 || item["filtro2"] == filtro2){
        List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
        Type tipo = Type(1, item["tipo"]);
        eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
      }
    }
    return eventos;

  }
  Future<List<Evento>> EventosFiltro1({required String filtro1}) async
  {
    var response = await  supabase.from('eventos')
        .select('*')
        .eq("tipo", "publico")
        .gte("fechainicio", DateTime.now());
    List<Evento> eventos = [];
    for (var item in response) {
      if(item["filtro1"] == filtro1 || item["filtro2"] == filtro1){
        List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
        Type tipo = Type(1, item["tipo"]);
        eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
      }
    }
    eventos.shuffle();
    return eventos;

  }
  Future<List<Filtro>> FiltrosDisponibles() async{
    return [Filtro(1, "musica"),Filtro(2, "fiesta"),Filtro(3, "gastronomia"),Filtro(4, "aventura"),];
  }
  Future<List<Evento>> EventosPropios() async
  {
    var response = await  supabase.from('eventos')
        .select('*')
        .eq("usuario", UserData.usuarioLog?.username);
    List<Evento> eventos = [];
    for (var item in response) {
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
      //print(eventos[0].name + eventos[0].fechaHoraFin+"llamada");
    }
    response = await  supabase.from('eventos')
        .select('*').contains("amigos", [UserData.usuarioLog?.username]);
    for (var item in response) {
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
      //print(eventos[0].name + eventos[0].fechaHoraFin+"llamada");
    }
    return eventos;

  }

  Future<List<Evento>> Recomendaciones() async
  {
    List<Evento> eventosRecomendados = await EventosRecomendados();
    List<Evento> eventosAmigos = await EventosAmigos();

    // Combinar las listas
    List<Evento> result = [...eventosRecomendados, ...eventosAmigos];

    // Eliminar elementos duplicados
    List<Evento> eventosSinDuplicados = Set.of(result).toList();

    return eventosSinDuplicados;
  }
}