import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/myComponents/MyLoginButton.dart';
import 'package:expense_tracker/myComponents/MyTextField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        leading: Row(
          children: [
            const SizedBox(
              width: 10,
            ), // Pushes the container to the right
            Container(
              width: 45.0,
              height: 45.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.offWhite,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.asset('assets/images/login.png', width: 250),
              Container(
                padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                child: Column(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign in to Cashflow",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const MyTextField(
                      "Enter your email", Icons.email_rounded, false),
                  const SizedBox(
                    height: 15,
                  ),
                  const MyTextField(
                      "Enter your password", Icons.lock_outline_rounded, true),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot password?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton("Sign in", 200, () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          endIndent: 10,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        color:
                            AppColors.offWhite, // Background color for the text
                        child: const Text('OR'),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/google_logo.png',
                        width: 40,
                      ),
                      title: const Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      trailing: const Text(""),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
