import 'package:flutter/material.dart';
import 'package:friendship/Class/compartir_enlace.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Pages/login_page.dart';
import 'package:friendship/Class/pantalla_confirmacion.dart';
import 'package:uni_links/uni_links.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(MyApp(navigatorKey));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp(this.navigatorKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey, // Usar el navigatorKey proporcionado
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/pantalla_confirmacion') {
          return MaterialPageRoute(builder: (context) => Confirmacion());
        }
      },
      home: CompEnlace(),
    );
  }
}