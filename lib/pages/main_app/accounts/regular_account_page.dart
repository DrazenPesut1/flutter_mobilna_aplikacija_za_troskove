// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker/myComponents/MyCard.dart';

class RegularAccountPage extends StatefulWidget {
  const RegularAccountPage({super.key});

  @override
  State<RegularAccountPage> createState() => _RegularAccountPageState();
}

class _RegularAccountPageState extends State<RegularAccountPage> {
  double totalBalance = 2000;
  String currency = '€';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite, // Assuming a custom color
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0), // Add space at the top
            // Use Text.rich to apply different styles to different parts of the text
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Total balance:', style: NormalBodyTextStyle(color: Colors.black).textStyle),
              TextSpan(text: '  $totalBalance' '$currency', style: MoneyBodyTextStyle(color: AppColors.moneyPositive).textStyle)
            ])),
            const MyAccountCard(card_title: 'Credit card', card_icon: Ionicons.card_outline, card_color: Colors.orange),
            const MyAccountCard(card_title: 'Cash', card_icon: Ionicons.cash_outline, card_color: Colors.green),
            const MyAccountCard(card_title: 'Paypal', card_icon: Ionicons.logo_paypal, card_color: Colors.blue),
            const MyAccountCard(card_title: 'Wallet', card_icon: Icons.wallet, card_color: Colors.brown)
          ],
        )
      ),
    );
  }
}



