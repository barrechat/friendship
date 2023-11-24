import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Widgets/filtro.dart';

class EventoWidget extends StatelessWidget {
  final Evento evento;

  const EventoWidget({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    const double width = 245;
    return GestureDetector(
        onLongPress: () {},
        child: Container(
          width: width,
          height: (width / 1.618),
          child: Card(
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
                Row(
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
              ],
            ),
          ),
        ));
  }
}
