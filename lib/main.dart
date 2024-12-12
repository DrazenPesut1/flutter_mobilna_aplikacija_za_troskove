import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_debts_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_regular_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_savings_account_page.dart';
import 'package:expense_tracker/pages/main_app/home_page.dart';
import 'package:expense_tracker/pages/main_app/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/pages/login_pages/welcome_page.dart';
import 'package:expense_tracker/pages/login_pages/register_page.dart';
import 'package:expense_tracker/pages/login_pages/login_page.dart';
import 'package:expense_tracker/pages/main_app/navigation_page.dart';

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
        '/navigation_page': (context) => const NavigationPage(),
        '/home_page': (context) => const HomePage(),
        '/transactions_page': (context) => const TransactionsPage(),
        '/add_regular_account' : (context) => const AddRegularAccountPage(),
        '/add_savings_account': (context) => const AddSavingsAccountPage(),
        '/add_debts_account' : (context) => const AddDebtsAccountPage()
      },
    );
  }
}
