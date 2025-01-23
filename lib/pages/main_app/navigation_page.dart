import 'package:expense_tracker/pages/main_app/accounts_page.dart';
import 'package:expense_tracker/pages/main_app/home_page.dart';
import 'package:expense_tracker/pages/main_app/statistics_page.dart';
import 'package:expense_tracker/pages/main_app/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  final screens = [
    const HomePage(),
    const TransactionsPage(),
    const StatisticsPage(),
    const AccountsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: screens, // Disable swipe gestures
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 70.0,
          shadowColor: Colors.black,
          backgroundColor: AppColors.offWhite,
          indicatorColor: AppColors.offWhite,
          elevation: 20,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
            final isSelected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: isSelected ? AppColors.primary : Colors.black,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
            final isSelected = states.contains(WidgetState.selected);
            return TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textGray,
              fontSize: 13,
              fontFamily: 'Poppins',
            );
          }),
        ),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(FontAwesomeIcons.house, color: AppColors.textGray),
                selectedIcon: Icon(FontAwesomeIcons.house),
                label: "Home"),
            NavigationDestination(
                icon: Icon(FontAwesomeIcons.receipt, color: AppColors.textGray),
                selectedIcon: Icon(FontAwesomeIcons.receipt),
                label: "Transactions"),
            NavigationDestination(
                icon: Icon(FontAwesomeIcons.chartPie, color: AppColors.textGray),
                selectedIcon: Icon(FontAwesomeIcons.chartPie),
                label: "Statistics"),
            NavigationDestination(
                icon: Icon(FontAwesomeIcons.wallet, color: AppColors.textGray),
                selectedIcon: Icon(FontAwesomeIcons.wallet),
                label: "Accounts"),
          ],
          selectedIndex: currentIndex,
          animationDuration: const Duration(milliseconds: 300), // Add custom animation duration
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200), // Duration of the animation
              curve: Curves.easeIn, // Curve for smooth transition
            );
          },
        ),
      ),
    );
  }
}

