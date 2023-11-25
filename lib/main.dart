import 'dart:async';

import 'package:flutter/material.dart';
import 'package:friendship/Pages/splash.dart';
import 'package:friendship/Class/compartir_enlace.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Pages/login_page.dart';
import 'package:friendship/Class/pantalla_confirmacion.dart';
import 'package:uni_links/uni_links.dart';

import 'Class/evento.dart';
import 'Class/filtro.dart';
import 'Class/type.dart';
import 'Widgets/eventoWidget.dart';
import 'Widgets/eventoWidgetBusqueda.dart';
import 'Widgets/listEventos.dart';
import 'Widgets/listEventosPendientes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  await init();
  await Supabase.initialize(
    url: 'https://peaoifidogwgoxzrpjft.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(MyApp(navigatorKey));
}
Future<void> init() async {
  // Solicitar permisos de ubicación
  var status = await Permission.location.request();

  if (status.isGranted) {
    print('Permisos de ubicación concedidos.');
  } else {
    print('Permisos de ubicación denegados.');

  }
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp(this.navigatorKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Filtro> filtros = [Filtro(1, "fiesta"), Filtro(2, "alcohol")];
    Evento evento = Evento(1,"evento", Type(1,"fiesta"),"descripcion descripcion descripcion descripcion","25€", filtros );
    List<Evento> eventos = [evento,evento,evento,evento,evento,evento,evento,evento,evento];
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
      home: LoginPage(supabase: supabase),
    );
  }
}