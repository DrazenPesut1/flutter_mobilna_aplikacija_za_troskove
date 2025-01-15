import 'package:expense_tracker/myComponents/HomeComponents/AddCategoryButton.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_debts_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_regular_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_savings_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_category/add_category_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_pages/expense_home_page.dart';
import 'package:expense_tracker/pages/main_app/home_page.dart';
import 'package:expense_tracker/pages/main_app/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/pages/login_pages/welcome_page.dart';
import 'package:expense_tracker/pages/login_pages/register_page.dart';
import 'package:expense_tracker/pages/login_pages/login_page.dart';
import 'package:expense_tracker/pages/main_app/navigation_page.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:page_transition/page_transition.dart';

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
      onGenerateRoute: (settings){
        switch(settings.name){
          case '/register_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const RegisterPage()
            );
          case '/login_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const LoginPage()
            );
          case '/navigation_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const NavigationPage()
            );
            case '/home_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const HomePage()
            );
            case '/add_category_page':
            return PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const AddCategoryPage()
            );
            case '/transactions_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const TransactionsPage()
            );
            case '/add_regular_account_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const AddRegularAccountPage()
            );
            case '/add_savings_account_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const AddSavingsAccountPage()
            );
            case '/add_debts_account_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const AddDebtsAccountPage()
            );
        }
      },
    );
  }
}
