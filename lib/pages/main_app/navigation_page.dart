import 'package:expense_tracker/pages/main_app/accounts_page.dart';
import 'package:expense_tracker/pages/main_app/home_page.dart';
import 'package:expense_tracker/pages/main_app/statistics_page.dart';
import 'package:expense_tracker/pages/main_app/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const TransactionsPage(),
    const StatisticsPage(),
    const AccountsPage(),
  ];

  int balance = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            height: 75.0,
            backgroundColor: AppColors.offWhite,
            shadowColor: Colors.black,
            elevation: 12,
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
                (Set<WidgetState> states) {
              final isSelected = states.contains(WidgetState.selected);
              return IconThemeData(
                color: isSelected ? AppColors.primary : Colors.black,
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) {
              final isSelected = states.contains(WidgetState.selected);
              return TextStyle(
                color: isSelected ? AppColors.primary : Colors.black,
                fontSize: 13,
              );
            })
          ),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Ionicons.home_outline),
                selectedIcon: Icon(Ionicons.home),
                label: "Home"),
            NavigationDestination(
                icon: Icon(Ionicons.receipt_outline),
                selectedIcon: Icon(Ionicons.receipt),
                label: "Transactions"),
            NavigationDestination(
                icon: Icon(Ionicons.stats_chart_outline),
                selectedIcon: Icon(Ionicons.stats_chart),
                label: "Statistics"),
            NavigationDestination(
                icon: Icon(Ionicons.wallet_outline),
                selectedIcon: Icon(Ionicons.wallet),
                label: "Accounts"),
          ],
          selectedIndex: currentIndex,
          animationDuration: const Duration(milliseconds: 100),
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
