import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  AppBar? _appBar;

  AppBarProvider() {
    // Asigna un valor predeterminado la primera vez que se inicia
    _appBar = AppBar(title: Text("Eventos"), centerTitle: true,);
  }

  AppBar? get appBar => _appBar;

  void updateAppBar(AppBar newAppBar) {
    _appBar = newAppBar;
    notifyListeners();
  }

  void clearAppBar() {
    _appBar = null; // o puedes asignar un AppBar predeterminado si lo prefieres
    notifyListeners();
  }
}