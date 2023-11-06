import 'package:flutter/material.dart';
import 'package:friendship/Widgets/qr.dart';
class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool extended = false;
  double size = 50;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
          onTap: () {
            setState(() {
              extended = !extended;
              size = extended ? 200.0 : 50.0;
            });
          },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: extended ? 200.0 : 100.0, // Cambia el ancho al hacer clic
          height: extended ? 200.0 : 100.0, // Cambia la altura al hacer clic
            child:  Center(
              child: QRImage(size)
            ),
        ),
      ),
    );
  }
}
