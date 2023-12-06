import 'package:flutter/material.dart';
import 'package:friendship/Pages/recomendacion.dart';
import 'package:friendship/Pages/searchresult.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  String busqueda ="";

  Widget resultado = Center(child: RecomendacionPage(),);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: Key("barra-busqueda"),
            controller: _searchController,
            onSubmitted: onSearchSubmitted,
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Enter search term',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),),
        Expanded(
        child: resultado)

      ],
    );
  }

  void onSearchSubmitted(String text) {
    if (text.isNotEmpty) {
    setState(() {
      busqueda= text;
      resultado = Center(child:SearchResultsPage(searchTerm: busqueda));
    });
    }
    else{
      setState(() {
        busqueda ="";
        resultado = Center(child: RecomendacionPage(),);
      });
    }
  }
}

