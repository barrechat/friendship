import 'package:flutter/material.dart';
import 'package:friendship/Class/grupo-amigos.dart';
import 'package:friendship/Class/user.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:friendship/Widgets/groupsWidget.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});
  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  GrupoAmigos grupo = GrupoAmigos("friend.ship", UserData.usuarioLog!);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: groupsWidget(grupo: grupo));
  }
}
