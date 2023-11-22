import 'dart:ui';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Pages/listfriends.dart';
import 'package:friendship/Pages/perfil.dart';
import 'package:friendship/Pages//create-event.dart';
import 'package:friendship/Class//compartir_enlace.dart';
import 'package:friendship/Pages/searching.dart';
import 'package:friendship/Widgets/dayview.dart';
import 'package:uni_links/uni_links.dart';
import 'package:friendship/Class/pantalla_confirmacion.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

DateTime get _now => DateTime.now();

class HomeState extends State<Home> {
  int actualPage = 0;

  final supabase = SupabaseClient(
    'https://peaoifidogwgoxzrpjft.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA',
  );

  @override
  Widget build(BuildContext context) {
    var controller = EventController();
    final event = CalendarEventData(
      title: "Event 1",
      date: DateTime(_now.year, _now.month, _now.day),
      event: "Event 1",
      description: "First Example",
      startTime:
          DateTime(_now.year, _now.month, _now.day, _now.hour, _now.minute),
      endTime:
          DateTime(_now.year, _now.month, _now.day, _now.hour + 3, _now.minute),
    );
    final event2 = CalendarEventData(
      title: "Event 2",
      date: DateTime(_now.year, _now.month, _now.day),
      event: "Event 2",
      description: "Second Example",
      startTime:
          DateTime(_now.year, _now.month, _now.day, _now.hour, _now.minute),
      endTime:
          DateTime(_now.year, _now.month, _now.day, _now.hour + 3, _now.minute),
    );

    List<Widget> pages = [
      Day(controller: controller, event: event),
      CompEnlace(),
      createEvent(),
      CompEnlace(),
      Search()
    ];

    return CalendarControllerProvider(
      controller: controller,
      child: MaterialApp(
          title: "friend.ship",
          theme: ThemeData(primarySwatch: Colors.indigo),
          scrollBehavior: ScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.trackpad,
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          home: Scaffold(
              appBar: AppBar(title: const Text("friend.ship")),
              body: pages[actualPage],
              bottomNavigationBar: BottomNavigationBar(
                  fixedColor: Colors.black,
                  backgroundColor: Colors.indigo,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    setState(() {
                      actualPage = index;
                    });
                  },
                  currentIndex: actualPage,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.workspaces_sharp),
                        label: "Friend List"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add), label: "AddEvent"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.qr_code), label: "QR"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle), label: "Account"),
                  ]))),
    );
  }

  //Links profundos

  @override
  void initState() {
    super.initState();
    initUniLinks();
    actualizarUsuario();
  }

  void actualizarUsuario() async {
    final response = await supabase
        .from('usuarios')
        .select('username')
        .eq('email', UserData.emailActual);

    if (response.isNotEmpty) {
      // Obtener el nombre de usuario
      var responseData = response[0]['username'];

      if (responseData != null) {
        UserData.usuarioLogueado = responseData;
      } else {
        print(
            'El campo "username" no está presente en la respuesta de Supabase.');
      }
    } else {
      print('No se encontraron datos para el usuario en la base de datos.');
    }
  }

  void initUniLinks() async {
    // Maneja los enlaces profundos cuando la aplicación se inicia
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      handleDeepLink(initialLink); // Convierte la cadena a un objeto Uri
    }

    // Escucha enlaces profundos en tiempo real
    linkStream.listen((String? link) {
      handleDeepLink(link); // Pasa la cadena directamente
    });
  }

  void handleDeepLink(String? link) {
    if (link != null) {
      final uri = Uri.parse(link);
      if (link.contains('miapp://pantalla_confirmacion')) {
        final username = uri.queryParameters['username'];
        if (username != null) {
          UserData.username = username;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Confirmacion(),
          ));
        }
      }
    }
  }
}


/*List<CalendarEventData<Evento>> _events = [
  CalendarEventData(
    date: _now,
    event: Evento(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: Event(title: "Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: Event(title: "Football Tournament"),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    event: Event(title: "Sprint Meeting."),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    event: Event(title: "Team Meeting"),
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    event: Event(title: "Chemistry Viva"),
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];
*/
