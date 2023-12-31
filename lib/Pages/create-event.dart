import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Widgets/dateTimePicker.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:friendship/Pages/home.dart';
import 'package:provider/provider.dart' as provider;
import 'package:friendship/Class/appbar.dart';

class createEvent extends StatefulWidget {
  final bool isFriendGroup;
  final String? grupoAmigos;
  const createEvent({Key? key, required this.isFriendGroup, this.grupoAmigos}) : super(key: key);

  @override
  State<createEvent> createState() => _createEventState();
}

class _createEventState extends State<createEvent> {
  List<String> listaTipoEvento = <String>["Publico", "Privado"];
  List<String> listaFiltros = <String>["Musica", "Fiesta", "Gastronomia", "Aventura"];
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
  String? filtro2 = '';
  final supabase = Supabase.instance.client;
  int numeroAleatorio = 0;
  String deportes = 'https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/filtros/deportes.png?t=2023-12-03T15%3A36%3A49.599Z';
  String estudio = 'https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/filtros/estudio.png?t=2023-12-03T15%3A37%3A23.052Z';
  String musica = 'https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/filtros/musica.png?t=2023-12-03T15%3A37%3A42.658Z';
  String ocio = 'https://peaoifidogwgoxzrpjft.supabase.co/storage/v1/object/public/filtros/ocio.png?t=2023-12-03T15%3A37%3A58.385Z';

  String textoNoEditable = 'YYYY-MM-DD';
  String textoHoraInicio = 'HH:MM';
  String textoHoraFin = 'HH:MM';

  List<String> selectedImages = [];

  void toggleImageSelection(String imagePath) {
    setState(() {
      if (selectedImages.contains(imagePath)) {
        selectedImages.remove(imagePath);
      } else {
        if (selectedImages.length < 2) {
          selectedImages.add(imagePath);
        }
      }
    });
  }

  void cambiarTexto(String texto) {
    setState(() {
      textoNoEditable = texto; // Cambia el texto cuando sea necesario
    });
  }

  void cambiarHoraIni(String texto) {
    setState(() {
      textoHoraInicio = texto; // Cambia el texto cuando sea necesario
    });
  }

  void cambiarHoraFin(String texto) {
    setState(() {
      textoHoraFin = texto; // Cambia el texto cuando sea necesario
    });
  }

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
                if(titulo == 'Evento añadido'){
                  provider.Provider.of<AppBarProvider>(context, listen: false).updateAppBar(
                    AppBar(title: Text("Eventos"), centerTitle: true,
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!, // Color del borde sombreado
                              width: 3.0, // Ancho del borde
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home(indiceInicial: 0,isFriendGroup: false,grupoAmigos: '',)),
                  );
                }
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
        child: GestureDetector(
          onTap: () {
          // Oculta el teclado al tocar fuera de cualquier campo de texto
          FocusScope.of(context).unfocus();
          },
          child:SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.0),
              Column(
                children: [
                  Text("Nombre del evento",
                      style: TextStyle(fontSize: 20.0)
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // O ajusta según sea necesario
                      ),
                      maxLength: 20,
                      onChanged: (text){
                        nombreDelEvento = text;
                      },
                    ),
                  ),
                  Text("Descripción del evento",
                      style: TextStyle(fontSize: 20.0)
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // O ajusta según sea necesario
                      ),
                      onChanged: (text){
                        descripcionDelEvento = text;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Fecha y hora del evento",
                  style: TextStyle(fontSize: 20.0)
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? escogida = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if(escogida != null){
                          fechaEscogida = escogida;
                          fechaEscogida_final = escogida;
                          cambiarTexto(DateFormat('yyyy-MM-dd').format(escogida).toString());
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                            decoration: ShapeDecoration(
                              color: Color(0xFFECC8FD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month, size: 40, color: Color(0xFF530577),),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            textoNoEditable,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
              SizedBox(height: 10,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () async {
                        horaInicial = await showTimePicker(
                            context: context,
                            initialTime:horaInicial ?? TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                        );
                        cambiarHoraIni(horaInicial!.format(context).toString());
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                            decoration: ShapeDecoration(
                              color: Color(0xFFECC8FD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time, size: 40, color: Color(0xFF530577),),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Inicio: ' + textoHoraInicio,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.0),
                    GestureDetector(
                      onTap: () async {
                        horaFinal = await showTimePicker(
                            context: context,
                            initialTime:horaFinal ?? TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                        );
                        cambiarHoraFin(horaFinal!.format(context).toString());
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                            decoration: ShapeDecoration(
                              color: Color(0xFFECC8FD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time, size: 40, color: Color(0xFF530577),),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Fin: ' + textoHoraFin,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Seleccionar Lugar del Evento',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // O ajusta según sea necesario
                  ),
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
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Seleccionar Tipo de Evento',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // O ajusta según sea necesario
                    ),
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
              ),
              SizedBox(height: 10.0),
              Text("Seleccionar filtros",
                  style: TextStyle(fontSize: 20.0)
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSelectableImage(
                        deportes, selectedImages.contains(deportes)),
                    buildSelectableImage(
                        ocio, selectedImages.contains(ocio)),
                    buildSelectableImage(
                        estudio, selectedImages.contains(estudio)),
                    buildSelectableImage(
                        musica, selectedImages.contains(musica)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if(nombreDelEvento == '' || tipoEvento == '' || descripcionDelEvento == '' ||
                        horaInicial?.format(context) == null || horaFinal?.format(context) == null ||
                        lugar == ''){
                      _showPopup(context, 'Error', 'Ningún campo puede estar vacío');
                    } else if(horaInicial != null && horaFinal != null){
                      int minutosTiempoIni = horaInicial!.hour * 60 + horaInicial!.minute;
                      int minutosTiempoFin = horaFinal!.hour * 60 + horaFinal!.minute;
                      if(minutosTiempoFin <= minutosTiempoIni){
                        _showPopup(context, 'Error', 'La hora de fin no puede ser menor o igual que la hora de inicio');
                      } else if (selectedImages.length < 2){
                        _showPopup(context, 'Error', 'Tienes que seleccionar 2 filtros');
                      } else {
                        String fechaFormateada = DateFormat('yyyy-MM-dd').format(fechaEscogida);
                        String fechaFormateadaFinal = DateFormat('yyyy-MM-dd').format(fechaEscogida_final);
                        String horaFormateada = "${horaInicial?.format(context)}:00";
                        String horaFinalFormateada = "${horaFinal?.format(context)}:00";
                        filtro = asignarFiltro(1);
                        filtro2 = asignarFiltro(2);
                        String usuario = '';
                        if(widget.isFriendGroup && widget.grupoAmigos != ''){
                          usuario = widget.grupoAmigos!;
                        } else {
                          usuario = UserData.usuarioLog!.username;
                        }
                        await supabase
                            .from('eventos')
                            .insert({
                          'id': numeroAleatorio,
                          'nombre': nombreDelEvento,
                          'tipo': tipoEvento,
                          'descripcion': descripcionDelEvento,
                          'usuario': usuario,
                          'fechainicio': fechaFormateada,
                          'horainicio': horaFormateada,
                          'lugar': lugar,
                          'horafin': horaFinalFormateada,
                          'fechafin': fechaFormateadaFinal,
                          'filtro': filtro,
                          'filtro2': filtro2,
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
      ),
    );
  }

  String asignarFiltro(int filtro){
    if(selectedImages[filtro-1] == musica){
      return 'musica';
    } else if(selectedImages[filtro-1] == deportes){
      return 'deportes';
    } else if(selectedImages[filtro-1] == ocio){
      return 'ocio';
    } else {
      return 'estudio';
    }
  }

  Widget buildSelectableImage(String imagePath, bool isSelected) {
    return GestureDetector(
      onTap: () {
        toggleImageSelection(imagePath);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          imagePath,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
