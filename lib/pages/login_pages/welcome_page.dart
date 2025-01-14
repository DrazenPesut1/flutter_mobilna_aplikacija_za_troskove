import 'package:flutter/material.dart';
import 'package:expense_tracker/myComponents/MyLoginButton.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:page_transition/page_transition.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: Column(
          children: [
            Image.asset('assets/images/savings_new.png'),
            const SizedBox(
              height: 20.0,
            ),
            const Text("Welcome to Cashflow!",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 33.0,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: [
                  Text(
                    "The best way to track and manage your finances.",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text("Never worry about spending a dime again!",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                  )
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            const Text("Let's get started",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50.0,
            ),
            MyButton("Create account", 285.0, () {
              Navigator.pushNamed(context, '/register_page');
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontFamily: 'Lato', fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_page')
                    ;
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
