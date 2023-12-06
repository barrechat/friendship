import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friendship/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//Sale
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('login', () {
    testWidgets('correct login', (tester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(app.MyApp(navigatorKey));
      await tester.enterText(find.byKey(Key("username")), "aritz479@gmail.com");
      await tester.enterText(find.byKey(Key("password")), "aritz2001");
      await tester.tap(find.byKey(Key("signin-btn")));
      await tester.pumpAndSettle(); // Wait for animations to complete
      await tester.tap(find.byKey(Key("AddEvent-btn")));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("nombre-evento")), "");
      await tester.enterText(find.byKey(Key("descripcion-evento")), "");
      await tester.tap(find.byKey(Key("add-evento")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("cerrar-popup")));
      await tester.pumpAndSettle();
      // Check if a widget with key "nombre-evento" is present
      expect(find.byKey(Key("nombre-evento")), findsOneWidget);
    });
  });
}
