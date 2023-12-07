import 'dart:math';
import 'dart:ui';

import 'package:friendship/Class/grupo-amigos.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'type.dart';
import 'package:friendship/Class/user.dart' as user;

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
  Future<int> generarNumeroAleatorioUnico(String tabla) async {
    final Random random = Random();
    int numeroAleatorio;
    do {
      // Genera un número aleatorio entre 0 y 9999999
      numeroAleatorio = random.nextInt(10000000);
      // Verifica si el número ya existe en la base de datos
      final response = await supabase.from(tabla).select().eq('id', numeroAleatorio);
      if (response.toString() != '[]') {
        // Si el número ya existe, vuelve a intentarlo
        numeroAleatorio = -1; // Puedes establecer cualquier valor que no sea un número válido
      }
    } while (numeroAleatorio == -1);
    return numeroAleatorio;
  }

  Future<int> obtenerIdGrupo(String nombre) async {
    var response = await supabase.from("grupos_amigos").select("*").eq("nombre", nombre);
    print(response);
    print(response[0]["id"]);
    return response[0]["id"];
  }
  Future<List<GrupoAmigos>> ObtenerGrupos() async {
    print("inicio");
    var response = await supabase.from("grupos_amigos").select("*").contains("participantes", [UserData.usuarioLog?.username]);
    List<GrupoAmigos> grupos = [];

    if (response.isNotEmpty) {
      for (final group in response) {
        var responsecreador = await supabase.from("usuarios").select("*").eq("username", group["creador"].toString().replaceAll('"', ""));
        print(responsecreador);
        user.User creador = user.User(
          responsecreador[0]["username"],
          responsecreador[0]["email"],
          responsecreador[0]["telefono"],
          responsecreador[0]["num_eventos"],
        );

        GrupoAmigos grupo = GrupoAmigos(group["nombre"], creador, group["descripcion"]);
        grupo.amigos = [];

        // Utilizar group["participantes"] en lugar de response["participantes"]
        if (group["participantes"] != null) {
          for (var amigo in group["participantes"]) {
            var userresponse = await supabase.from("usuarios").select("*").eq("username", amigo.toString());

            if (userresponse.isNotEmpty) {
              grupo.amigos.add(user.User(
                userresponse[0]["username"],
                userresponse[0]["email"],
                userresponse[0]["telefono"],
                userresponse[0]["num_eventos"],
              ));
            }
          }
        }
        grupos.add(grupo);
      }
      return grupos;
    } else {
      return grupos;
    }
  }


  Future<int> addGrupoAmigos(String nombre, String descripcion,user.User creador) async {
    int id = await generarNumeroAleatorioUnico("grupos_amigos");
    print("crear");
    supabase.from("grupos_amigos").insert({
      "id":id,
      "nombre": nombre,
      "participantes":"[${creador.username}]",
      "creador" : creador.username,
      "descripcion": descripcion,
    });
    return id;
  }
  Future<void> addAmigoAGrupoAmigos(int id, user.User nuevo) async {
    var group = await supabase.from("grupos_amigos").select("*").eq("id", id);
    var participantes ;
    if (group.isNotEmpty) {
      var grupo = group[0];
      if (grupo != null) {
        participantes= grupo['participantes'];
        if (!participantes.contains(nuevo.username)) {
          participantes.add(nuevo.username);
        }

    }
      await supabase
          .from('grupos_amigos')
          .update({ 'participantes': participantes })
          .match({ 'id': id });
      }
    }
  Future<void> rmAmigoDeGrupoAmigos(int id, user.User eliminado) async {
    var group = await supabase.from("grupos_amigos").select("*").eq("id", id);
    var participantes ;
    if (group.isNotEmpty) {
      var grupo = group[0];
      if (grupo != null) {
        participantes= grupo['participantes'];

        participantes ??= [];

        if (participantes.contains(eliminado.username)) {
          participantes.remove(eliminado.username);
        }

      }
      await supabase
          .from('grupos_amigos')
          .update({ 'participantes': participantes })
          .match({ 'id': id });
    }
  }

  Future<List<Evento>> EventosGrupo(String nombre) async {
    var response = await supabase.from("eventos").select("*").eq("usuario", nombre);
    List<Evento> eventos = [];
    for (var item in response) {
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros, item["fechainicio"]+" "+ item["horainicio"],item["fechafin"]+" "+ item["horafin"],item["lugar"],item["usuario"] ));
      //print(eventos[0].name + eventos[0].fechaHoraFin+"llamada");
    }
    return eventos;
  }

  Future<void> EditGrupo(int id, String descripcion)async{
    var group = await supabase.from("grupos_amigos").select("*").eq("id", id);
    if(group.isNotEmpty){
      print("entro");
      await supabase.from("grupos_amigos").update({'descripcion' : descripcion}).match({'id':id});

    }

  }
  Future<List<user.User>> ObtenerAmigos() async{
    List<user.User> amigos =[];
    print([UserData.usuarioLog?.username]);
    var response = await supabase.from("usuarios").select("*").eq("username", UserData.usuarioLog?.username);
    for (var amigo in response[0]["lista_amigos"]) {
      var userresponse = await supabase.from("usuarios").select("*").eq("username", amigo.toString());
      if (userresponse.isNotEmpty) {
        print("entro");

        amigos.add(user.User(
          userresponse[0]["username"],
          userresponse[0]["email"],
          userresponse[0]["telefono"],
          userresponse[0]["num_eventos"],
        ));
      }
    }
    return amigos;

  }
}

