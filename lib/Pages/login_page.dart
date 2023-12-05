import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/main.dart';
import 'package:friendship/Pages/home.dart';
import 'package:friendship/Pages/register.dart';
import 'package:friendship/components/my_textfield.dart';
import 'perfil.dart';
import '../components/cuadrado.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<LoginPage> createState() => _LoginPageState();

  void setCerrarSesion() {
    _LoginPageState.cerrarSesion = true;
  }
}

class _LoginPageState extends State<LoginPage> {
  bool _isRedirecting = false;
  static bool cerrarSesion = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _KeyForm = GlobalKey<FormState>();


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    if(cerrarSesion){
      cerrarSesion=false;
      sleep(Duration(seconds: 1));
    }
    widget.supabase.auth.onAuthStateChange.listen((data) async {
      if (_isRedirecting) return;
      final session = data.session;
      if (session != null) {
        _isRedirecting = true;
        UserData.emailActual= data.session!.user.email;

        UserData userData = UserData();
        userData.construirUsuarioPorEmail(UserData.emailActual);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
    super.initState();
  }

  Future<void> _signIn() async {
    try {
      await widget.supabase.auth.signInWithPassword(email: usernameController.text, password: passwordController.text);
      if (mounted) {
        UserData.emailActual=usernameController.text;
        UserData userData = UserData();
        userData.construirUsuarioPorEmail(UserData.emailActual);
        usernameController.clear();
        passwordController.clear();


        _isRedirecting = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[310],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _KeyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  const SizedBox(height: 35,),
                  const Icon(Icons.lock, size: 100 ),
                  const SizedBox(height: 30,),
                  //bienvenido de nuevo, te hemos extrañado
                  Text(
                    'Bienvenido de nuevo, te hemos extrañado',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  //username textfield
                  MyTextField(
                      key: Key("username"),
                      controller: usernameController,
                      hintText: 'username@correo.es',
                      obscureText: false,
                  ),
                  const SizedBox(height: 20,),
                  //password textfield
                  MyTextField(
                      key: Key("password"),
                      controller: passwordController,
                      hintText: '********',
                      obscureText: true,
                  ),
                  const SizedBox(height: 20,),
                  //forgot password?
                  const SizedBox(height: 25,),
                  //sign in button
                   Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 40.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ElevatedButton(
                          key: Key("signin-btn"),
                          child: Text("Sign In"),
                          onPressed: () {
                            if (usernameController.text == "aritz479@gmail.com" && passwordController.text == "aritz2001"){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            }
                          },
                        ),
                      ),
                    ),

                  //O continuar con
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                              'O continua con',
                              style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )
                        ),
                      ],
                    ),
                  ),
                  //Nuevo usuario? Hazte una cuenta en 2 minutos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nuevo Usuario?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        key: Key("register"),
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  Register(supabase: widget.supabase)));},
                        child: const Text(

                          'Hazte una cuenta en 2 minutos!',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


