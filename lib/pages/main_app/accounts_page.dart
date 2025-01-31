import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/pages/main_app/accounts/account_pages/regular_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/account_pages/savings_account_page.dart';
import 'package:expense_tracker/pages/main_app/accounts/account_pages/debt_account_page.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:ionicons/ionicons.dart';

class AccountsPage extends StatefulWidget{
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> with TickerProviderStateMixin{
  static const List<Tab> myTabs = 
  <Tab>[
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            tabs: myTabs,
            labelColor: AppColors.primary,
            labelStyle: BoldBodyTextStyle(color: AppColors.textGray).textStyle,
            unselectedLabelColor: AppColors.textGray,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            controller: tabController,
          ),
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