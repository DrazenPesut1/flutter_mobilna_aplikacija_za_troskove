import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/myComponents/MyButton.dart';
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Text(
                    "The best way to track and manage your finances.",
                    style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 14).textStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text("Never worry about spending a dime again!",
                      style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 14).textStyle
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text("Let's get started",
                style: BoldBodyTextStyle(color: Colors.black).textStyle),
            const SizedBox(
              height: 50.0,
            ),
            MyButton("Create account", 260.0, () {
              Navigator.pushNamed(context, '/register_page');
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 14).textStyle,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_page')
                    ;
                  },
                  child: Text(
                    "Sign in",
                    style: BoldVariableFontTextStyle(color: AppColors.primary, fontSize: 14).textStyle,
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
