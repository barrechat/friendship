import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Widgets/dateTimePicker.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';

class createEvent extends StatefulWidget {
  const createEvent({super.key});

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  List<String> listaDeAmigos = <String>["Aritz","Alex"];
  List<String> listaTipoEvento = <String>["Publico", "Privado"];
  late DateTime fechaEscogida = DateTime.now();
  late DateTime fechaEscogida_final= DateTime.now().add(Duration(hours: 2));
  String nombreDelEvento = 'aaaa';
  String descripcionDelEvento = 'cccccc';
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  String? Amigo;
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      maxWidth: 1200,
      minWidth: 480,
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.resize(400, name: MOBILE),
        ResponsiveBreakpoint.autoScale(600, name: TABLET),
        ResponsiveBreakpoint.resize(800, name: DESKTOP),
        ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
      ],
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Text("Nombre del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              TextFormField(
                onChanged: (text){
                  nombreDelEvento = text;
                },
              ),
              SizedBox(height: 20.0),
              Text("Descripción del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              TextFormField(
                onChanged: (text){
                  descripcionDelEvento = text;
                },
              ),
              SizedBox(height: 20.0),
              Text("Fecha y hora del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[

                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? escogida = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if(escogida != null){
                          fechaEscogida = escogida;
                        }
                      },
                      child: const Text('Fecha inicial'),
                    ),
                    SizedBox(width: 40.0),
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? escogida = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if(escogida != null){
                          fechaEscogida_final = escogida;
                        }
                      },
                      child: const Text('Fecha final'),
                    ),
                  ]
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    ElevatedButton(
                        onPressed: () async{
                          horaInicial = await showTimePicker(
                              context: context,
                              initialTime:horaInicial ?? TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                          );
                        },
                        child: const Text('Escoger hora inicial')
                    ),
                    SizedBox(width: 40.0),
                    ElevatedButton(
                      onPressed: () async{
                        horaFinal = await showTimePicker(
                            context: context,
                            initialTime:horaFinal ?? TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                        );
                      },
                      child: const Text('Escoger hora final '),
                    ),
                  ]
              ),
              SizedBox(height: 20.0),
              Text("Seleccionar amigos",
                  style: TextStyle(fontSize: 20.0)
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                  items: listaDeAmigos.map((e){
                    /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                    return DropdownMenuItem(
                        child: Text(e),
                        value: e
                    );
                  }).toList(),
                  onChanged: (text){
                    Amigo = text;
                  }
              ),
              SizedBox(height: 20.0),
              Text("Seleccionar tipo de evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                  items: listaTipoEvento.map((e){
                    return DropdownMenuItem(
                        child: Text(e),
                        value: e
                    );
                  }).toList(),
                  onChanged: (text){
                    Amigo = text;
                  }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  supabase
                      .from('eventos')
                      .insert({'id':Random().nextInt(100) + 100, 'nombre':nombreDelEvento, 'tipo':'publico','descripcion': descripcionDelEvento,'usuario':UserData.usuarioLog?.username ?? 'Abel','fechaInicio':fechaEscogida.withoutTime, 'horaInicio': horaInicial,'horafin':horaFinal,'fechafin':fechaEscogida_final.withoutTime, 'amigos':[""], 'filtro1':"fiesta", 'filtro2':"aventura"});
                },
                child: const Text('Añadir Evento'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
