import 'package:flutter/material.dart';
import 'package:friendship/Pages/home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                  offset: Offset(5.0, 5.0)
              )
            ],
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20)
        ),
        margin: EdgeInsets.only(top:50, left: 20, right: 20, bottom: 50),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logoFS.jpg", height: 170),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "usuario@correo.com"
                  ),
                ),
                SizedBox(height: 50,),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "********"
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 70),
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: ElevatedButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()));},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20))
                    )
                ),
                SizedBox(height: 100,),
                Text("Nuevo usuario? Crea una cuenta")
              ],
            ),
          ),
        ),
      ),
    );
  }
}