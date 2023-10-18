import 'package:flutter/material.dart';

class createEvent extends StatefulWidget {
  const createEvent({super.key});

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  List<String> listaDeAmigos = <String>["A","B","C","D","E","F","G"];
  List<String> listaTipoEvento = <String>["A","B","C","D","E","F","G"];

  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  SizedBox(height: 20.0),
                    Text("Nombre del evento",
                          style: TextStyle(fontSize: 20.0)
                          ),
                  SizedBox(height: 20.0),
                  TextFormField(),
                  SizedBox(height: 20.0),
                  Text("Descripción del evento",
                      style: TextStyle(fontSize: 20.0)
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(),
                  SizedBox(height: 20.0),
                  Text("Fecha del evento",
                      style: TextStyle(fontSize: 20.0)
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                    },
                    child: const Text('Escoger fecha'),
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
                      onChanged: (e){}
                  ),
                  SizedBox(height: 20.0),
                  Text("Seleccionar tipo de evento",
                      style: TextStyle(fontSize: 20.0)
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                      items: listaTipoEvento.map((e){
                        /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                        return DropdownMenuItem(
                            child: Text(e),
                            value: e
                        );
                      }).toList(),
                      onChanged: (e){}
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
