import 'package:expense_tracker/myComponents/MyCard.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_debts_account_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/myComponents/MyAddAccountButton.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyColorBox.dart';
import 'package:expense_tracker/myComponents/MyPlusButton.dart';

class DebtsAccountPage extends StatefulWidget{
  const DebtsAccountPage({super.key});

  @override
  State<DebtsAccountPage> createState() => _DebtsAccountPageState();
}

class _DebtsAccountPageState extends State<DebtsAccountPage> {

  List<MyDebtsAccountCard> debtsAccountsList = [];

  void navigateToAddAccountPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDebtsAccountPage()),
    );

    // Check if data is returned and add new account
    if (result != null) {
      debugPrint("All ok here.");
      setState(() {
        debtsAccountsList.add(
          MyDebtsAccountCard(
            card_title: result['accountName'],
            card_description: result['description'],
            card_balance: result['initialPaidOffAmount'],
            card_icon: result['selectedIcon'],
            card_color: result['selectedColor'], 
            goal: result['debtGoalAmount'],
            type: result['selectedType'],
            progress: (1.0 * result['initialPaidOffAmount']) / result['debtGoalAmount'],
          ) ,
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(children: [
        Expanded(
              child: ListView.builder(
                itemCount: debtsAccountsList.length,  // Dynamically update the item count
                itemBuilder: (context, index) {
                  MyDebtsAccountCard account = debtsAccountsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: account,  // Render the MyRegularAccountCard widget
                  );
                },
              ),
            ),
         MyAddAccountButton(
            account_type: 'Debt',
             function: () => navigateToAddAccountPage(context),
          )
      ],) 
    );
  }
}