import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/myComponents/MyButton.dart';
import 'package:expense_tracker/myComponents/MyTextField.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.offWhite,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Ionicons.chevron_back),
          iconSize: 30.0
        ),
        title: Text("Sign in", style: BoldHeaderTextStyle(color: Colors.black).textStyle,),
        centerTitle: true,
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
                  MyButton("Sign in", double.infinity, () {Navigator.pushNamed(context, '/navigation_page');}),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Forgot password?",
                        style: BoldVariableFontTextStyle(color: AppColors.primary, fontSize: 14).textStyle),
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
                    title: Text("Continue with Google", style: NormalBodyTextStyle(color: AppColors.textGray).textStyle, textAlign: TextAlign.center,),
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
