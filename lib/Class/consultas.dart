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
    final username = UserData.username;
    var response = await  supabase.from('eventos')
      .select('*')
      .eq("tipo", "publico")
      .gte("fechainicio", DateTime.now())
      .ilike("nombre", '$nombreEvento%');
    List<Evento> eventos = [];
    //print(DateTime.now().);
    for (var item in response) {
      print(item);
      List<Filtro> filtros = [Filtro(1, item["filtro"]), Filtro(2, item["filtro2"])];
      Type tipo = Type(1, item["tipo"]);
      eventos.add(Evento(item["id"], item["nombre"], tipo , item["descripcion"], "0", filtros));
    }
    return eventos;

  }

}