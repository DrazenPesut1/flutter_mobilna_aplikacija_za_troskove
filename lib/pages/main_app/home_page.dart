import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_pages/expense_home_page.dart';  // Make sure this is properly imported
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double total_balance = 4124.36; // balance in euros
  String displayed_screen = "expense"; // Default is "expense"

  // Toggle between Expense and Income screen
  void toggleScreen(String screen) {
    setState(() {
      displayed_screen = screen; // Change screen state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'January 2025',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.pencil, color: Colors.black,))
        ],
        surfaceTintColor: AppColors.offWhite,
        backgroundColor: AppColors.offWhite,
        elevation: 3,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            // Container for both the label and the balance
            SizedBox(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total balance",
                      style: NormalBodyTextStyle(color: AppColors.textGray).textStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$total_balance EUR",
                      style: MoneyBodyTextStyle(color: Colors.black, fontSize: 26.0).textStyle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Row with the buttons to toggle between "Expenses" and "Incomes"
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => toggleScreen("expense"), // Change to "expense"
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: displayed_screen == "expense" ? AppColors.primary : AppColors.offWhite,
                        border: Border.all(
                          color: displayed_screen == "expense" ? Colors.transparent : AppColors.primary,
                          width: 1.5
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Expenses",
                          style: MoneyBodyTextStyle(
                            color: displayed_screen == "expense" ? AppColors.offWhite : AppColors.primary,
                            fontSize: 17,
                          ).textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => toggleScreen("income"), // Change to "income"
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: displayed_screen == "income" ? AppColors.primary : AppColors.offWhite,
                        border: Border.all(
                          color: displayed_screen == "income" ? Colors.transparent : AppColors.primary,
                          width: 1.5
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Incomes",
                          style: MoneyBodyTextStyle(
                            color: displayed_screen == "income" ? Colors.white : AppColors.primary,
                            fontSize: 17,
                          ).textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Show the ExpenseHomePage if "expense" is selected, otherwise show "Income"
            Expanded(
              child: displayed_screen == "expense"
                  ? ExpenseHomePage() // Render ExpenseHomePage
                  : Center(child: Text("Income Content Here")), // Placeholder for "Incomes"
            ),
          ],
        ),
      ),
    );
  }
}
