import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.size, { super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    if(size<200){
      return Icon(Icons.qr_code, size: size,);
    }
    else{
    return QrImageView(
      data: 'Esto tiene que ser una consulta a la base de datos para conseguir el link',
      version: QrVersions.auto,
      size: size,
      gapless: false,
    );
  }}
}