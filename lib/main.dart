import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/pages/welcome_page.dart';
import 'package:expense_tracker/pages/register_page.dart';
import 'package:expense_tracker/pages/login_page.dart';
import 'package:expense_tracker/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomePage(),
      routes: {
        '/register_page': (context) => const RegisterPage(),
        '/login_page': (context) => const LoginPage(),
        '/home_page': (context) => const HomePage(),
      },
    );
  }
}
