import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Class/consultas.dart';
import '../Class/evento.dart';

class CreateEventPage extends StatefulWidget {
  final String eventName;

  const CreateEventPage({Key? key, required this.eventName}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {

  late String _eventName;


  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );

  @override
  void initState() {
    super.initState();
    _eventName = widget.eventName;
    obtenerEvento(_eventName);
  }

  @override
  Widget build(BuildContext context) {

    // Aquí puedes usar `eventName` para cargar y editar los datos del evento
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Evento: $_eventName'),
      ),
      body: Center(
        child: Text('Editar detalles del evento aquí'),
      ),
    );
  }
  Future<Evento> obtenerEvento(nombre) async
  {
    Evento eventoObtenido = await Consultas().obtenerEventoNombre(nombre);
    return eventoObtenido;
  }



}
