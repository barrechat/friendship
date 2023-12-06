import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friendship/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('register', () {

    testWidgets('access register', (tester) async {
      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(app.MyApp(navigatorKey));
      await tester.tap(find.byKey(Key("register")));
      await tester.pumpAndSettle(); // Wait for animations to complete

      // Check if a widget with key "username" is present
      expect(find.byKey(Key("register")), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key("nombre")), "aritz");
      await tester.enterText(find.byKey(Key("numero")), "634885181");
      await tester.enterText(find.byKey(Key("email")), "aritz478@gmail.com");
      await tester.enterText(find.byKey(Key("contraseña")), "aritz");
      await tester.tap(find.byKey(Key("register-btn")));
      await tester.pumpAndSettle(); //
      expect(find.byKey(Key("nav")), findsOneWidget);
    });
  });
}
