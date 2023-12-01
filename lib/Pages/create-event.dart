import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Widgets/dateTimePicker.dart';

class createEvent extends StatefulWidget {
  const createEvent({super.key});

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  List<String> listaDeAmigos = <String>["A","B","C","D","E","F","G"];
  List<String> listaTipoEvento = <String>["Chill","Tardeo","Concierto"];
  late DateTime fechaEscogida;
  late DateTime fechaEscogida_final;
  String nombreDelEvento = '';
  String descripcionDelEvento = '';
  TimeOfDay? horaInicial;
  TimeOfDay? horaFinal;
  String? Amigo;
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Column(
                children: [
                  SizedBox(height: ScreenUtil().setHeight(10)),
                    Text("Nombre del evento",
                          style: TextStyle(fontSize:  ScreenUtil().setSp(18))
                          ),
                  TextFormField(
                    onChanged: (text){
                      nombreDelEvento = text;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Descripción del evento",
                      style: TextStyle(fontSize:  ScreenUtil().setSp(18))
                  ),
                  TextFormField(
                    onChanged: (text){
                      descripcionDelEvento = text;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Fecha y hora del evento",
                      style: TextStyle(fontSize:  ScreenUtil().setSp(18))
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Row(
                      children:[
                        SizedBox(width: ScreenUtil().setWidth(50)),

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
                        SizedBox(width: ScreenUtil().setWidth(40)),
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
                        SizedBox(width: ScreenUtil().setWidth(5)),

                        ElevatedButton(
                          onPressed: () async{
                              horaInicial = await showTimePicker(
                                  context: context,
                                  initialTime:horaInicial ?? TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                              );
                          },
                          child: const Text('Escoger hora inicial')
                        ),
                        SizedBox(width: ScreenUtil().setWidth(40)),
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
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Seleccionar amigos",
                      style: TextStyle(fontSize:  ScreenUtil().setSp(18))
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
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
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Seleccionar tipo de evento",
                      style: TextStyle(fontSize:  ScreenUtil().setSp(18))
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
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
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  ElevatedButton(
                    onPressed: () {
                      /*supabase
                          .from('eventos')
                          .insert({'id':1, 'nombre':'Abel', 'tipo':'evento','descripcion':,'usuario':'Abeldel','fechaInicio':, 'horaInicio': ,'horafin':,'fechafin':});
                    */},
                    child: const Text('Añadir Evento'),
                  )


                ]
                );
  }
}
