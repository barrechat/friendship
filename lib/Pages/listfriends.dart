import 'package:flutter/material.dart';
import 'package:friendship/Class/grupo-amigos.dart';
import 'package:friendship/Class/consultas.dart';
import '../Class/user.dart';
import '../Class/usernameAuxiliar.dart';
import '../Widgets/listGroupsWidget.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GrupoAmigos>>(
        future: Consultas().ObtenerGrupos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GrupoAmigos> eventos = snapshot.data ?? [];
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListGroupsWidget(groups: eventos),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Crear Grupo'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      labelText: 'Título del Grupo',
                                    ),
                                  ),
                                  TextFormField(
                                    maxLines: 5,
                                    controller: _descriptionController,
                                    decoration: InputDecoration(
                                      labelText: 'Descripción del Grupo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  print(UserData.usuarioLog!.username);
                                  Consultas().addGrupoAmigos(_titleController.text,_descriptionController.text, UserData.usuarioLog!);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Crear Grupo'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Crear Grupo"),
                  ),
                ],
              ),
            );
          }
        });
  }
}
