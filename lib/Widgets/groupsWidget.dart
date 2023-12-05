import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendship/Class/grupo-amigos.dart';

import '../Class/user.dart';

class groupsWidget extends StatelessWidget {
  final GrupoAmigos grupo;

  const groupsWidget({super.key, required this.grupo});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 350,
            height: 403,
            decoration: BoxDecoration(
              color: Color(0xFF5094F9),
              borderRadius: BorderRadius.circular(25),
              ),

            child: Stack(children: [
              Positioned(
                  left: 20,
                  top: 40,
                  child: Text(grupo.name, style: const TextStyle(
                    color: Color(0xFF032A64),
                    fontSize: 30,
                    fontFamily: 'Google Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.04,
                  ),)),
              Positioned.fill(
                right: -28,
                  child:Image.asset("assets/SistemaSolarAzul.png")),
              Positioned(
                  bottom: 0,
                  child:Container(
                  child: Text(grupo.name),
                  width: 350,
                  height: 53,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                )
              )
            ],

            )
        )
    );
  }
}
