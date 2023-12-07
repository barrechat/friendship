import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friendship/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('perfil', () {
    testWidgets('Acceso a perfil', (tester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(app.MyApp(navigatorKey));
      await tester.enterText(find.byKey(Key("username")), "aritz479@gmail.com");
      await tester.enterText(find.byKey(Key("password")), "aritz2001");
      await tester.tap(find.byKey(Key("signin-btn")));
      await tester.pumpAndSettle(); // Wait for animations to complete

      // Check if a widget with key "home" is present
      await tester.tap(find.byKey(Key("Account-btn")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("avatar")), findsOneWidget );
    });
    testWidgets('Cerrar sesion', (tester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(app.MyApp(navigatorKey));
      await tester.enterText(find.byKey(Key("username")), "aritz479@gmail.com");
      await tester.enterText(find.byKey(Key("password")), "aritz2001");
      await tester.tap(find.byKey(Key("signin-btn")));
      await tester.pumpAndSettle(); // Wait for animations to complete

      await tester.tap(find.byKey(Key("Account-btn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("ajustes")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("cerrar-sesion")));
      await tester.pumpAndSettle();
      // Check if page "login" is present
      expect(find.byKey(Key("username")), findsOneWidget );
    });
    testWidgets('Ver QR', (tester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(app.MyApp(navigatorKey));
      await tester.enterText(find.byKey(Key("username")), "aritz479@gmail.com");
      await tester.enterText(find.byKey(Key("password")), "aritz2001");
      await tester.tap(find.byKey(Key("signin-btn")));
      await tester.pumpAndSettle(); // Wait for animations to complete

      // Check if a widget with key "home" is present
      await tester.tap(find.byKey(Key("Account-btn")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("opcion-qr")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("popup-qr")), findsOneWidget );
    });
    testWidgets('Ver trofeos', (tester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(app.MyApp(navigatorKey));
      await tester.enterText(find.byKey(Key("username")), "aritz479@gmail.com");
      await tester.enterText(find.byKey(Key("password")), "aritz2001");
      await tester.tap(find.byKey(Key("signin-btn")));
      await tester.pumpAndSettle(); // Wait for animations to complete

      // Check if a widget with key "home" is present
      await tester.tap(find.byKey(Key("Account-btn")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("copa-del-mundo")), findsOneWidget );
    });
  });
}
