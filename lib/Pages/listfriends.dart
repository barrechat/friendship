import 'package:flutter/material.dart';
import 'package:friendship/Class/grupo-amigos.dart';
import 'package:friendship/Class/user.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:friendship/Widgets/groupsWidget.dart';

import '../Class/consultas.dart';
import '../Widgets/listGroupsWidget.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});
  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GrupoAmigos>>(
        future: Consultas().ObtenerGrupos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center( child:CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<GrupoAmigos> eventos = snapshot.data ?? [];
            return SingleChildScrollView(
                child: Column(
              children: [
                ListGroupsWidget(groups: eventos),
              ],
            ));
          }
        });
  }
}
