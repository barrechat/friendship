import 'package:flutter/material.dart';
import 'package:friendship/Class/consultas.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'package:friendship/Widgets/eventoWidget.dart';
import 'package:friendship/Widgets/listEventoBusqueda.dart';
import 'package:friendship/Class/type.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../Widgets/listEventos.dart';
class RecomendacionPage extends StatelessWidget {

  const RecomendacionPage({super.key});

  // You can perform your search logic here based on the searchTerm

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      maxWidth: 1200,
      minWidth: 480,
      defaultScale: true,
      breakpoints: [
        ResponsiveBreakpoint.resize(480, name: MOBILE),
        ResponsiveBreakpoint.autoScale(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      ],
      child: Material(
        child: SingleChildScrollView(
            child:Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Text("De tus amigos",  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  FutureBuilder<List<Evento>>(

                    future: Consultas().EventosAmigos(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Evento> eventos = snapshot.data ?? [];
                        return Center(
                          child: EventosWidget(eventos: eventos),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                    child: Text("Segun tus preferencias",  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  FutureBuilder<List<Evento>>(

                    future: Consultas().EventosFiltro1(filtro1: "fiesta"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Evento> eventos = snapshot.data ?? [];
                        return Center(
                          child: EventosWidget(eventos: eventos),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                    child: Text("Recomendados",  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  FutureBuilder<List<Evento>>(

                    future: Consultas().EventosRecomendados(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Evento> eventos = snapshot.data ?? [];
                        return Center(
                          child: EventosWidget(eventos: eventos),
                        );
                      }
                    },
                  ),
                ]
            ),
        ),
      ),
    );
  /*
    return Column(

      children: [
        SizedBox(
          height: ScreenUtil().setHeight(34),
          child: Text("De tus amigos",  style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        FutureBuilder<List<Evento>>(

      future: Consultas().EventosAmigos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Evento> eventos = snapshot.data ?? [];
          return Center(
            child: EventosWidget(eventos: eventos),
          );
        }
      },
    ),
        SizedBox(
          height: ScreenUtil().setHeight(34),
          child: Text("Segun tus preferencias",  style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        FutureBuilder<List<Evento>>(

          future: Consultas().EventosFiltro1(filtro1: "fiesta"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Evento> eventos = snapshot.data ?? [];
              return Center(
                child: EventosWidget(eventos: eventos),
              );
            }
          },
        ),
        SizedBox(
          height: ScreenUtil().setHeight(34),
          child: Text("Recomendados",  style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        FutureBuilder<List<Evento>>(

          future: Consultas().EventosRecomendados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Evento> eventos = snapshot.data ?? [];
              return Center(
                child: EventosWidget(eventos: eventos),
              );
            }
          },
        ),
      ]
    );*/
  }
}