import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/reusable_widgets/myButton.dart';
import 'package:expense_tracker/reusable_widgets/myTextField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_rounded),
          iconSize: 30.0
        ),
        title: const Text("Sign in", style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Image.asset('assets/images/login.png', width: 250),
              Container(
                padding: const EdgeInsets.fromLTRB(35, 15, 35, 10),
                child: Column(children: [
                  const MyTextField("Enter your email", Icons.email_rounded, false),
                  const SizedBox(
                    height: 15,
                  ),
                  const MyTextField("Enter your password", Icons.lock_outline_rounded, true),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton("Sign in", double.infinity, () {Navigator.pushNamed(context, '/home_page');}),
                  const SizedBox(
                    height: 12,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text("Forgot password?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                  ),
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
                        color: AppColors.offWhite, // Background color for the text
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
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: Image.asset('assets/images/google_logo.png', width: 40,),
                    title: const Text("Continue with Google", style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
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
