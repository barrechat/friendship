import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Widgets/dateTimePicker.dart';

class createEvent extends StatefulWidget {
  const createEvent({super.key});

  @override
  State<createEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<createEvent> {
  List<String> listaDeAmigos = <String>["A", "B", "C", "D", "E", "F", "G"];
  List<String> listaTipoEvento = <String>["Chill", "Tardeo", "Concierto"];
  late DateTime fechaEscogida;
  late DateTime fechaEscogida_final;
  String nombreDelEvento = '';
  String descripcionDelEvento = '';
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  String? amigo;
  String? tipoEvento;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20.0),
        Text("Nombre del evento", style: TextStyle(fontSize: 20.0)),
        TextFormField(
          key: Key("nombre-evento"),
          onChanged: (text) {
            setState(() {
              nombreDelEvento = text;
            });
          },
        ),
        SizedBox(height: 20.0),
        Text("Descripción del evento", style: TextStyle(fontSize: 20.0)),
        TextFormField(
          onChanged: (text) {
            setState(() {
              descripcionDelEvento = text;
            });
          },
        ),
        SizedBox(height: 20.0),
        Text("Fecha y hora del evento", style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final DateTime? escogida = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (escogida != null) {
                    setState(() {
                      fechaEscogida = escogida;
                    });
                  }
                },
                child: const Text('Fecha inicial'),
              ),
            ),
            SizedBox(width: 40.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final DateTime? escogida = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (escogida != null) {
                    setState(() {
                      fechaEscogida_final = escogida;
                    });
                  }
                },
                child: const Text('Fecha final'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  horaInicial = await showTimePicker(
                    context: context,
                    initialTime: horaInicial ??
                        TimeOfDay(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute),
                  );
                },
                child: const Text('Escoger hora inicial'),
              ),
            ),
            SizedBox(width: 40.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  horaFinal = await showTimePicker(
                    context: context,
                    initialTime: horaFinal ??
                        TimeOfDay(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute),
                  );
                },
                child: const Text('Escoger hora final '),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text("Seleccionar amigos", style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 20.0),
        DropdownButtonFormField(
          items: listaDeAmigos.map((e) {
            return DropdownMenuItem(child: Text(e), value: e);
          }).toList(),
          onChanged: (text) {
            setState(() {
              amigo = text as String?;
            });
          },
        ),
        SizedBox(height: 20.0),
        Text("Seleccionar tipo de evento", style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 20.0),
        DropdownButtonFormField(
          items: listaTipoEvento.map((e) {
            return DropdownMenuItem(child: Text(e), value: e);
          }).toList(),
          onChanged: (text) {
            setState(() {
              tipoEvento = text as String?;
            });
          },
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            /*supabase
                .from('eventos')
                .insert({
              'id': 1,
              'nombre': 'Abel',
              'tipo': 'evento',
              'descripcion': descripcionDelEvento,
              'usuario': 'Abeldel',
              'fechaInicio': fechaEscogida,
              'horaInicio': horaInicial,
              'horafin': horaFinal,
              'fechafin': fechaEscogida_final
            });*/
          },
          child: const Text('Añadir Evento'),
        ),
      ],
    );
  }
}
