import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:friendship/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:friendship/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('login', () {
    testWidgets('correct login', (tester) async {
          app.main();
          await tester.pumpAndSettle();
          //tester.enterText(find.byKey(Key("username")), "alex@gmail.com");
          //tester.enterText(find.byKey(Key("password")), "alex1234");
          //tester.tap(find.byKey(Key("singin-btn")));

        });
  });
}