import 'package:flutter/material.dart';
import 'package:friendship/Pages/home.dart';
import 'package:friendship/Pages/register.dart';
import 'package:friendship/components/my_textfield.dart';
import 'package:friendship/components/my_button.dart';
import '../components/cuadrado.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[310],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                    controller: usernameController,
                    hintText: 'username@correo.es',
                    obscureText: false,
                ),
                const SizedBox(height: 20,),
                //password textfield
                MyTextField(
                    controller: passwordController,
                    hintText: '********',
                    obscureText: true,
                ),
                const SizedBox(height: 20,),
                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Has olvidado tu contraseña?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                //sign in button
                MyButton(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()));},),
                const SizedBox(height: 25,),
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
                //Google + apple sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    Cuadrado(imagePath: "assets/google.png"),
                    //apple
                    Cuadrado(imagePath: "assets/apple.png"),
                  ],
                ),
                //Nuevo usuario? Hazte una cuenta en 2 minutos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nuevo Usuario?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  Register()));},
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
    );
  }
}


