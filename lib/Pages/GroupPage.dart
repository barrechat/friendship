import 'package:flutter/material.dart';
import 'package:friendship/Class/consultas.dart';
import 'package:friendship/Class/grupo-amigos.dart';
import '../Class/user.dart';
import 'home.dart';

class GroupPage extends StatefulWidget {
  final GrupoAmigos group;

  GroupPage({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupPage> createState() => GroupPageState();
}

class GroupPageState extends State<GroupPage> {
  late TextEditingController _descriptionController;
  bool isEditingDescription = false;
  List<User> amigos = [];

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
        text: widget.group.descripcion.replaceAll('"', ""));
    amigos.addAll(widget.group.amigos);
  }

  List<Widget> _buildAvatars() {
    List<Widget> avatars = [];

    for (User participante in amigos) {
      String initials = participante.username.substring(0, 1).toUpperCase();
      avatars.add(
        Center(
          child: CircleAvatar(
            maxRadius: 15,
            backgroundColor: Color(0xFF032A64),
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return avatars;
  }

  Future<void> _saveChanges() async {
    int id = await widget.group.ObtenerId();
    setState(() {
      if (isEditingDescription) {
        widget.group.descripcion = '"${_descriptionController.text}"';
        print(id);
        Consultas().EditGrupo(id, widget.group.descripcion);
      }
      isEditingDescription = !isEditingDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7DBF7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,

              child: Center(child: Image.asset("assets/SistemaSolarMorado.png")),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Expanded(
                child:
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(widget.group.name),
                        isEditingDescription
                            ? TextFormField(
                          controller: _descriptionController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Ingrese la descripción',
                          ),
                        )
                            : TextFormField(
                          enabled: false,
                          controller: _descriptionController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Ingrese la descripción',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _saveChanges();
                          },
                          child:
                          Text(isEditingDescription ? 'Guardar' : 'Editar'),
                        ),
                        Text("Participantes"),
                        Row(children: _buildAvatars()),
                        Text("Planes"),
                        // ... tu código para mostrar eventos ...
                      ],
                    ),
                  ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

