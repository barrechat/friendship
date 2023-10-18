import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

final supabase = Supabase.instance.client;

class Insertar_en_bd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        supabase
            .from('usuarios')
            .insert({'id':1, 'username':'Abeldel', 'nombre':'Abel', 'contraseña':'deltoro123',
                      'email':'abeldel123@gmail.com', 'telefono':123456789});
      },
      child: const Text('Prueba BD'),
    );
  }
}