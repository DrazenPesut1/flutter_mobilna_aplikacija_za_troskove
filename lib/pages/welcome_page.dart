import 'package:flutter/material.dart';
import 'package:expense_tracker/reusable_widgets/purple_button.dart';
import 'package:expense_tracker/styles/app_colors.dart';

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
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Text(
                "The best way to track and manage your finances. Never worry about spending a dime again!",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            const Text("Let's get started",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50.0,
            ),
            PurpleButton("Create account", 285.0, (){
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
                    Navigator.pushNamed(context, '/login_page');
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.myPurple),
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
