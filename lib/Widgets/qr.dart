import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.size, { super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    String nombreUsuario = "aritz";
    String link = 'https://aplicacionpin.000webhostapp.com/redireccion.html?username='+nombreUsuario;
    if(size<200){
      return Icon(Icons.qr_code, size: size,);
    }
    else{
    return QrImageView(
      data: link,
      version: QrVersions.auto,
      size: size,
      gapless: false,
    );
  }}
}