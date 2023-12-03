import 'dart:math';

import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Widgets/filtroWidget.dart';

class EventoWidget extends StatelessWidget {
  final Evento evento;

  const EventoWidget({super.key, required this.evento});



  @override
  Widget build(BuildContext context) {
    Color makeColorLighter(Color color) {
      int r = color.red + ((255 - color.red) ~/ 1.5).round();
      int g = color.green + ((255 - color.green) ~/ 1.5).round();
      int b = color.blue + ((255 - color.blue) ~/ 1.5).round();

      r = r > 255 ? 255 : r;
      g = g > 255 ? 255 : g;
      b = b > 255 ? 255 : b;

      return Color.fromARGB(color.alpha, r, g, b);
    }

    const double width = 245;
    final Random random = Random();
    final List<Color> colores = [
      Color(0xFFD287F6),
      Color(0xFF84CEEB),
      Color(0xFFFFB347),
      Color(0xFF20BD8E),
    ];

    Color getColor() {
      return colores[random.nextInt(colores.length)];
    }
    Color colorSeleccionado = getColor();
    return GestureDetector(
        onLongPress: () {},
        child: Container(
          width: width,
          height: (width / 1.618),
          child: Card(
            color: colorSeleccionado,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    evento.name,
                    style: const TextStyle(fontSize: 25),
                  ),
                  subtitle: Text(
                    evento.descripcion,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                Container(
                  color: makeColorLighter(colorSeleccionado),
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(children: <Widget>[
                        FiltroWidget(filtro: evento.filtros[0]),
                        const SizedBox(
                          width: 10,
                        ),
                        FiltroWidget(filtro: evento.filtros[1])
                      ]),
                      Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: IconButton(
                            style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(Colors.black12),
                            ),
                            onPressed: () => {},
                            icon: const Center(child: Icon(Icons.share_rounded)),
                          )),

                    ],
                  ),
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        )
    );
  }
}
