import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SuperbaseCredentials {
  static const String url =  "https://peaoifidogwgoxzrpjft.supabase.co";
  static const String key =  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBlYW9pZmlkb2d3Z294enJwamZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY2MDExNDcsImV4cCI6MjAxMjE3NzE0N30.xPOHo3wz93O9S0kWU9gbGofVWlFOZuA7JB9UMAMoBbA";
  static SupabaseClient supabaseClient = SupabaseClient(url, key);
  final supabase = Supabase.instance.client;
}

// extension ShowSnackBar on BuildContext {
//   void showSnackBar({
//     required String message,
//     Color backgroundColor = Colors.white,
//   }) {
//     ScaffoldMessenger.of(this).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: backgroundColor,
//       margin: const EdgeInsets.all(8),
//       behavior: SnackBarBehavior.floating,
//     ));
//   }

//   void showErrorSnackBar({required String message}) {
//     showSnackBar(message: message, backgroundColor: Colors.red);
//   }
// }


class SuperButton extends StatelessWidget {
  const SuperButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.width,
    this.color = Colors.black,
  }) : super(key: key);
  final String text;
  final Function()? onTap;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        child: Text(text),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {Key? key, required this.mobileLayout, required this.desktopLayout})
      : super(key: key);
  final Widget mobileLayout;
  final Widget desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileLayout;
        } else {
          return desktopLayout;
        }
      }),
    );
  }
}
