import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_debts_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_regular_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_savings_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/edit_accounts/edit_regular_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/add_category_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/add_expense_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/add_income_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/make_transfer_page.dart';
import 'package:expense_tracker/pages/main_app/home_page.dart';
import 'package:expense_tracker/pages/main_app/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/pages/login_pages/welcome_page.dart';
import 'package:expense_tracker/pages/login_pages/register_page.dart';
import 'package:expense_tracker/pages/login_pages/login_page.dart';
import 'package:expense_tracker/pages/main_app/navigation_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomePage(),
      onGenerateRoute: (settings){
        switch(settings.name){
          case '/register_page':
            return PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: const Duration(milliseconds: 300),
              settings: settings,
              child: const RegisterPage(),
              childCurrent: WelcomePage()
            );
          case '/login_page':
            return PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: const Duration(milliseconds: 300),
              settings: settings,
              child: const LoginPage(),
              childCurrent: WelcomePage()
            );
          case '/navigation_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 300),
              settings: settings,
              child: const NavigationPage(),
              childCurrent: RegisterPage()
            );
            case '/home_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const HomePage()
            );
            case '/add_expense_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 350),
              settings: settings,
              child: const AddExpensePage(),
            );
            case '/add_income_page':
            return PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: const Duration(milliseconds: 350),
              settings: settings,
              child: const AddIncomePage(),
              childCurrent: HomePage()
            );
            case '/add_category_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const AddCategoryPage(),
            );
            case '/make_transfer_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: MakeTransferPage(),
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
            case '/edit_regular_account_page':
            return PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 200),
              settings: settings,
              child: const EditRegularAccountPage()
            );
        }
      },
    );
  }
}
