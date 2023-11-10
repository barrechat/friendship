import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friendship/Widgets/dateTimePicker.dart';

class createEvent extends StatefulWidget {
  const createEvent({super.key});

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  List<String> listaDeAmigos = <String>["A","B","C","D","E","F","G"];
  List<String> listaTipoEvento = <String>["A","B","C","D","E","F","G"];
  late DateTime fechaEscogida;
  late DateTime fechaEscogida_final;
  String nombreDelEvento = '';
  String descripcionDelEvento = '';
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  String? Amigo;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      children:[
                        SizedBox(width: 65.0),

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
                          child: const Text('Frcha inicial'),
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
                      children:[
                        SizedBox(width: 20.0),

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
                    onPressed: () {},
                    child: const Text('Añadir Evento'),
                  )


                ]
                );
  }
}
