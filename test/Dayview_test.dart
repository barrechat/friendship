// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friendship/Class/evento.dart';
import 'package:friendship/Class/usernameAuxiliar.dart';

import 'package:friendship/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/Widgets/dayview.dart';
import 'package:friendship/Class/consultas.dart';

void main() {
  test('imposible de testear ', () async {
    // arrange
    UserData userData = new UserData();
    userData.construirUsuarioPorEmail("alex@gmail.com");
    Consultas consultor = Consultas();
    List<Evento> eventos = await consultor.EventosPropios();
    List<CalendarEventData> eventosExpected = Evento.convertirEventos(eventos);

    // act
    Day calendario = new Day();
    List<CalendarEventData<Object?>>? eventosResult = null; // userData.GetEventos();


    // assert
    expect(eventosResult, eventosExpected);
  });
}
