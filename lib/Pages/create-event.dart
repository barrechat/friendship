import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
  List<String> listaTipoEvento = <String>["Publico", "Privado"];
  List<String> listaFiltros = <String>["","Musica", "Fiesta", "Gastronomia", "Aventura"];
  List<String> listaLugar = <String>["Valencia", "Alicante","Castellón"];
  late DateTime fechaEscogida = DateTime.now();
  late DateTime fechaEscogida_final= DateTime.now().add(Duration(hours: 2));
  String nombreDelEvento = '';
  String descripcionDelEvento = '';
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  String? tipoEvento = '';
  String? lugar = '';
  String? filtro = '';
  final supabase = Supabase.instance.client;
  int numeroAleatorio = 0;

  void _showPopup(BuildContext context,String titulo, String texto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(texto),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void generarNumeroAleatorioUnico() async {
    final Random random = Random();

    do {
      // Genera un número aleatorio entre 0 y 9999999
      numeroAleatorio = random.nextInt(10000000);
      // Verifica si el número ya existe en la base de datos
      final response = await supabase.from('eventos').select().eq('id', numeroAleatorio);
      if (response.toString() != '[]') {
        // Si el número ya existe, vuelve a intentarlo
        numeroAleatorio = -1; // Puedes establecer cualquier valor que no sea un número válido
      }
    } while (numeroAleatorio == -1);
  }

  @override
  Widget build(BuildContext context) {
    generarNumeroAleatorioUnico();
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
              SizedBox(height: 10.0),
              Text("Nombre del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              TextFormField(
                onChanged: (text){
                  nombreDelEvento = text;
                },
              ),
              SizedBox(height: 10.0),
              Text("Descripción del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              TextFormField(
                onChanged: (text){
                  descripcionDelEvento = text;
                },
              ),
              SizedBox(height: 10.0),
              Text("Fecha y hora del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              SizedBox(height: 10.0),
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
              SizedBox(height: 10.0),
              Text("Seleccionar lugar del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              DropdownButtonFormField(
                  items: listaLugar.map((e){
                    return DropdownMenuItem(
                        child: Text(e),
                        value: e
                    );
                  }).toList(),
                  onChanged: (text){
                    lugar = text;
                  }
              ),
              SizedBox(height: 10.0),
              Text("Seleccionar tipo de evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              DropdownButtonFormField(
                  items: listaTipoEvento.map((e){
                    return DropdownMenuItem(
                        child: Text(e),
                        value: e
                    );
                  }).toList(),
                  onChanged: (text){
                    tipoEvento = text;
                  }
              ),
              SizedBox(height: 10.0),
              Text("Seleccionar filtro",
                  style: TextStyle(fontSize: 20.0)
              ),
              DropdownButtonFormField(
                  items: listaFiltros.map((e){
                    return DropdownMenuItem(
                        child: Text(e),
                        value: e
                    );
                  }).toList(),
                  onChanged: (text){
                    filtro = text;
                  }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if(nombreDelEvento == '' || tipoEvento == '' || descripcionDelEvento == '' ||
                        horaInicial?.format(context) == null || horaFinal?.format(context) == null ||
                        lugar == ''){
                      _showPopup(context, 'Error', 'Ningún campo excepto los filtros puede estar vacío');
                    } else if(horaInicial != null && horaFinal != null){
                      int minutosTiempoIni = horaInicial!.hour * 60 + horaInicial!.minute;
                      int minutosTiempoFin = horaFinal!.hour * 60 + horaFinal!.minute;
                      if(minutosTiempoFin <= minutosTiempoIni){
                        _showPopup(context, 'Error', 'La hora de fin no puede ser menor o igual que la fecha de inicio');
                      } else {
                        String fechaFormateada = DateFormat('yyyy-MM-dd').format(fechaEscogida);
                        String fechaFormateadaFinal = DateFormat('yyyy-MM-dd').format(fechaEscogida_final);
                        String horaFormateada = "${horaInicial?.format(context)}:00";
                        String horaFinalFormateada = "${horaFinal?.format(context)}:00";
                        if(filtro == ''){
                          filtro = null;
                        } else {
                          filtro = filtro?.toLowerCase();
                        }
                        final response = await supabase
                            .from('eventos')
                            .insert({
                          'id': numeroAleatorio,
                          'nombre': nombreDelEvento,
                          'tipo': tipoEvento,
                          'descripcion': descripcionDelEvento,
                          'usuario': UserData.usuarioLog?.username,
                          'fechainicio': fechaFormateada,
                          'horainicio': horaFormateada,
                          'lugar': lugar,
                          'horafin': horaFinalFormateada,
                          'fechafin': fechaFormateadaFinal,
                          'filtro': filtro,
                          'amigos': null
                        });
                        _showPopup(context, 'Evento añadido', 'El evento se ha añadido con éxito');
                      }
                    }
                  } catch (e) {
                    print("Error: $e");
                  }
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
