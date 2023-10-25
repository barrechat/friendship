import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await supabase.from('usuarios').upsert([
        {
          'id': 1,
          'username': 'Abeldel',
          'nombre': 'Abel',
          'contraseña': 'deltoro123',
          'email': 'abeldel123@gmail.com',
          'telefono': 123456789,
        },
      ]);

      if (response != null) {
        if (response.error != null) {
          print('Error al insertar en Supabase: ${response.error?.message}');
        } else {
          print('Usuario insertado con éxito.');
        }
      } else {
        print('La respuesta de Supabase es nula.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar Usuario en Supabase'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text('Insertar Usuario en Supabase'),
            ),
          ),
        ),
      ),
    );
  }
}