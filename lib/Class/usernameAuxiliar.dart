import 'package:friendship/Class/user.dart' as usuario;
import 'package:supabase_flutter/supabase_flutter.dart';

class UserData {
  static String? username;
  static String? emailActual;
  static usuario.User? usuarioLog;

  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );

  Future<void> actualizarContadorEventos() async {
    usuarioLog!.eventosCreados++;
    await supabase
        .from('usuarios')
        .update({ 'num_eventos': usuarioLog!.eventosCreados})
        .match({ 'username': usuarioLog!.username });
  }

  void construirUsuarioPorEmail(String? email) async {
    var usernameAux = '';
    var telefonoAux = 0;
    var eventosAux = 0;
    final usernameResponse = await supabase
        .from('usuarios')
        .select('username')
        .eq('email', email);

      if (usernameResponse.isNotEmpty) {
        usernameAux = usernameResponse[0]['username'];
      }

    final phoneResponse = await supabase
        .from('usuarios')
        .select('telefono')
        .eq('email', email);

    if (phoneResponse.isNotEmpty) {
      telefonoAux = phoneResponse[0]['telefono'];
    }

    final eventosResponse = await supabase
        .from('usuarios')
        .select('num_eventos')
        .eq('email', email);

    if (eventosResponse.isNotEmpty) {
      eventosAux = eventosResponse[0]['num_eventos'];
    }

    usuarioLog = new usuario.User(usernameAux, email!, telefonoAux, eventosAux);
    }
  }