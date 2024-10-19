import 'package:expense_tracker/reusable_widgets/purple_button.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                color: AppColors.myPurple,
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
                      "Log in to your account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: "Enter your email",
                      labelStyle: TextStyle(fontSize: 15.0),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1.4)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_open_rounded),
                      labelText: "Enter your password",
                      labelStyle: TextStyle(fontSize: 15.0),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot password?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.myPurple)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PurpleButton("Log in", 200, () {}),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            endIndent: 10,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          color: Colors.white, // Background color for the text
                          child: const Text('or'),
                        ),
                        const Expanded(
                          child: Divider(
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
