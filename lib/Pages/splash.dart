import 'package:flutter/material.dart';
import 'package:friendship/Class/compartir_enlace.dart';
import '../main.dart';
import 'perfil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.supabase});
  final SupabaseClient supabase;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isRedirect = false;


  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (_isRedirect||!mounted) {
      return;
    }

    _isRedirect = true;
    final session = widget.supabase.auth.currentSession;

    if (session != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Perfil()),
      );
    }
    else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CompEnlace()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

