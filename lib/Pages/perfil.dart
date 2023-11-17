import 'package:flutter/material.dart';
import 'package:friendship/Pages/splash.dart';
import 'package:friendship/Widgets/qr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'package:friendship/components/my_textfield.dart';
import 'package:friendship/main.dart';
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
      child: Column(
        children: [
          GestureDetector(
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
          GestureDetector(
            onTap: () async {
              final navigator = Navigator.of(context);

              try {
                await supabase.auth.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SplashPage(supabase: supabase)),
                );
              } on AuthException catch (error) {
                context.showErrorSnackBar(message: error.message);
              } catch (error) {
                context.showErrorSnackBar(message: 'Unexpected error occurred');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
