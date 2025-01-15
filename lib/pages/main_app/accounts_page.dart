import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/pages/main_app/accounts/accounts_pages/regular_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/accounts_pages/savings_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/accounts_pages/debt_account_page.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class AccountsPage extends StatefulWidget{
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> with TickerProviderStateMixin{
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Regular'),
    Tab(text: 'Savings'),
    Tab(text: 'Debts',)
  ];

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
 void dispose() {
   tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          onPressed: (){
            
          }, 
          icon: const Icon(Ionicons.menu)
        ),
        title: Text("Accounts",
            style: BoldHeaderTextStyle(color: Colors.black).textStyle,
          ),
        centerTitle: true,
        surfaceTintColor: AppColors.offWhite,
        backgroundColor: AppColors.offWhite,
        bottom: TabBar(
          tabs: myTabs,
          labelColor: AppColors.primary,
          labelStyle: NormalBodyTextStyle(color: Colors.black).textStyle,
          unselectedLabelColor: Colors.black,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          RegularAccountPage(),
          SavingsAccountPage(),
          DebtsAccountPage()
        ]
      )
    );
  }
}