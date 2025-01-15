import 'package:expense_tracker/pages/main_app/accounts/add_accounts/add_regular_account_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyCard.dart';
import 'package:expense_tracker/myComponents/MyAddAccountButton.dart';

class RegularAccountPage extends StatefulWidget {
  const RegularAccountPage({super.key});

  @override
  State<RegularAccountPage> createState() => _RegularAccountPageState();
}

class _RegularAccountPageState extends State<RegularAccountPage> {
  double totalBalance = 2000;
  String currency = '€';

  List<MyRegularAccountCard> regularAccountsList = [];

  void navigateToAddAccountPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRegularAccountPage()),
    );

    // Check if data is returned and add new account
    if (result != null) {
      debugPrint("All ok here.");
      setState(() {
        regularAccountsList.add(
          MyRegularAccountCard(
            card_title: result['accountName'],
            card_description: result['description'],
            card_balance: result['initialBalance'],
            card_icon: result['selectedIcon'],
            card_color: result['selectedColor'],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite, // Custom background color
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0), // Add space at the top
            // Display total balance with currency
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Total balance:', style: NormalBodyTextStyle(color: Colors.black).textStyle),
              TextSpan(text: '  $totalBalance' '$currency', style: MoneyBodyTextStyle(color: AppColors.moneyPositive, fontSize: 19.0).textStyle),
            ])),
            
            const SizedBox(height: 20.0), // Optional space before the list

            // Use Expanded to allow ListView to take available space
            Expanded(
              child: ListView.builder(
                itemCount: regularAccountsList.length,  // Dynamically update the item count
                itemBuilder: (context, index) {
                  MyRegularAccountCard account = regularAccountsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: account,  // Render the MyRegularAccountCard widget
                  );
                },
              ),
            ),
            MyAddAccountButton(
              account_type: 'Regular',
              function: () => navigateToAddAccountPage(context),
            ),
          ],
        ),
      ),
    );
  }
}
