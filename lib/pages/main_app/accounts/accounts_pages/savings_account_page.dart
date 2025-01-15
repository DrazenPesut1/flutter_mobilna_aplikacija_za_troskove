import 'package:expense_tracker/myComponents/MyCard.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_savings_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyPlusButton.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:expense_tracker/myComponents/MyAddAccountButton.dart';

class SavingsAccountPage extends StatefulWidget{
  const SavingsAccountPage({super.key});

  @override
  State<SavingsAccountPage> createState() => _SavingsAccountPageState();
}

class _SavingsAccountPageState extends State<SavingsAccountPage> {
  double initial_amount = 0;
  double goal = 0;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  double progress = 450;

  List<MySavingsAccountCard> savingsAccountsList = [];

  void navigateToAddAccountPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddSavingsAccountPage()),
    );

    // Check if data is returned and add new account
    if (result != null) {
      debugPrint("All ok here.");
      setState(() {
        savingsAccountsList.add(
          MySavingsAccountCard(
            card_title: result['accountName'],
            card_description: result['description'],
            card_balance: result['initialSavedAmount'],
            goal: result['savingsGoalAmount'],
            card_icon: result['selectedIcon'],
            card_color: result['selectedColor'], 
            progress: (1.0 * result['initialSavedAmount']) / result['savingsGoalAmount'],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: savingsAccountsList.length,  // Dynamically update the item count
                itemBuilder: (context, index) {
                  MySavingsAccountCard account = savingsAccountsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: account,  // Render the MyRegularAccountCard widget
                  );
                },
              ),
            ),
          MyAddAccountButton(
            account_type: 'Savings',
             function: () => navigateToAddAccountPage(context),
          )
        ],
      )
    );
  }
}