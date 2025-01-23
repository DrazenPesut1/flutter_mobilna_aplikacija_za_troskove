import 'package:expense_tracker/pages/main_app/accounts/home_pages/income_home_page.dart';
import 'package:expense_tracker/pages/main_app/storage/account_storage/regular_account_storage.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_pages/expense_home_page.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double total_balance = 0;
  String displayed_screen = "expense";

  double total_expenses = 0;
  double total_income = 0;

  NumberFormat formatter =
      NumberFormat.currency(locale: "de_DE", decimalDigits: 2);

  Future<void> _loadTotalBalance() async {
    total_balance = await RegularAccountStorage.loadTotalBalance();
    setState(() {});
  }

  void toggleScreen(String screen) {
    setState(() {
      displayed_screen = screen;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTotalBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                  },
                  icon: Icon(FontAwesomeIcons.trashCan))
            ],
          ),
        )),
      ),
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        /*title: Text(
          '< January 2025 >',
          style: BoldHeaderTextStyle(color: Colors.black).textStyle,
        ),
        centerTitle: true,*/
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.pencil,
                color: Colors.black,
              ))
        ],
        surfaceTintColor: AppColors.offWhite,
        backgroundColor: AppColors.offWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Total balance",
                    style: NormalBodyTextStyle(color: Colors.black).textStyle,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatter.format(total_balance),
                    style:
                        MoneyBodyTextStyle(color: Colors.black, fontSize: 30.0)
                            .textStyle,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => toggleScreen("expense"),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: displayed_screen == "expense"
                                ? AppColors.primary
                                : AppColors.offWhite,
                            border: Border.all(
                              color: displayed_screen == "expense"
                                  ? Colors.transparent
                                  : AppColors.primary,
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
                                color: displayed_screen == "expense"
                                    ? AppColors.offWhite
                                    : AppColors.primary,
                                fontSize: 17,
                              ).textStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => toggleScreen("income"),
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: displayed_screen == "income"
                                ? AppColors.primary
                                : AppColors.offWhite,
                            border: Border.all(
                              color: displayed_screen == "income"
                                  ? Colors.transparent
                                  : AppColors.primary,
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
                                color: displayed_screen == "income"
                                    ? Colors.white
                                    : AppColors.primary,
                                fontSize: 17,
                              ).textStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: displayed_screen == "expense"
                  ? ExpenseHomePage((updatedBalance) {
                  setState(() {
                  total_balance = updatedBalance;
              });
            })
          : IncomeHomePage((updatedBalance) {
            setState(() {
              total_balance = updatedBalance;
            });
          })
                )
            ],),
          ),
        ),
      ),
    );
  }
}
