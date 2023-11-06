import 'package:flutter/material.dart';
import 'package:friendship/Pages/home.dart';
import 'package:friendship/components/my_textfield.dart';
import '../components/cuadrado.dart';

class Register extends StatelessWidget {
  Register ({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final aliasController = TextEditingController();
  final phoneController = TextEditingController();
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
                const SizedBox(height: 10,),
                const Icon(Icons.account_circle_outlined, size: 100 ),
                const SizedBox(height: 10,),
                //Registro de usuario
                Text(
                  'REGISTRATE',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
                //Nombre/Alias textfield
                MyTextField(
                  controller: aliasController,
                  hintText: 'Nombre o Alias',
                  obscureText: false,
                ),
                //Numero de telefono textfield
                MyTextField(
                  controller: phoneController,
                  hintText: '+34 666 666 666',
                  obscureText: false,
                ),
                //username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'username@correo.es',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
                const SizedBox(height: 15,),
                //sign up button
                GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()));},
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
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
                          'O registrate con',
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
                //Google + apple sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    Cuadrado(imagePath: "assets/google.png"),
                    //apple
                    Cuadrado(imagePath: "assets/apple.png"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
