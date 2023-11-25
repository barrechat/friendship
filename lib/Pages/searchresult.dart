import 'package:flutter/material.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Class/filtro.dart';
import 'package:friendship/Widgets/listEventoBusqueda.dart';
import 'package:friendship/Class/type.dart';
class SearchResultsPage extends StatelessWidget {
  final String searchTerm;

  const SearchResultsPage({super.key, required this.searchTerm});

  // You can perform your search logic here based on the searchTerm

  @override
  Widget build(BuildContext context) {
    List<Filtro> filtros = [Filtro(1,"fiesta"), Filtro(2,"juerga")];
    Evento evento = Evento(1, "name", Type(1,"fiesta"), "descripcion", "precio", filtros);
    List<Evento> eventos = [evento,evento,evento,evento,evento,evento,evento];
    return Center(
        child: ListEventosBusqueda(eventos: eventos)
    );
  }
}