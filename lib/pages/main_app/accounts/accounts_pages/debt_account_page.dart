import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/myComponents/HomeComponents/RoundedActionButton.dart';
import 'package:expense_tracker/myComponents/RoundedIconActionButtonReversed.dart';
import 'package:expense_tracker/myComponents/RoundedIconActionButton.dart';
import 'package:expense_tracker/pages/main_app/storage/account_storage/debts_account_storage.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/myComponents/FloatingAddButton.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DebtsAccountPage extends StatefulWidget {
  const DebtsAccountPage({super.key});

  @override
  State<DebtsAccountPage> createState() => _DebtsAccountPageState();
}

class _DebtsAccountPageState extends State<DebtsAccountPage> {
  List<MyDebtsAccountCard> debtsAccountsList = [];
  NumberFormat formatter = NumberFormat.currency(locale: "de_DE", decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    List<Map<String, dynamic>> loadedAccountsData = await DebtsAccountStorage.loadAccounts();
    setState(() {
      debtsAccountsList = loadedAccountsData.map((accountData) {
        debugPrint(accountData['selectedType'].toString());
        return MyDebtsAccountCard(
          card_title: accountData['accountName'],
          card_description: accountData['description'],
          card_balance: accountData['initialPaidOffAmount'],
          goal: accountData['debtGoalAmount'],
          card_icon: Icon(
            IconData(accountData['selectedIcon']),
            color: Color(accountData['selectedColor']),
            size: 33.0,
          ),
          card_color: Color(accountData['selectedColor']),
          progress: (1.0 * accountData['initialPaidOffAmount']) / accountData['debtGoalAmount'],
          type: accountData['selectedType'],
        );
      }).toList();
    });
  }

  void navigateToAddAccountPage(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add_debts_account_page');
    if (result != null) {
      final Map<String, dynamic> accountData = result as Map<String, dynamic>;
      DebtsAccountStorage.saveAccount(accountData);
      setState(() {
        debtsAccountsList.add(
          MyDebtsAccountCard(
            card_title: accountData['accountName'],
            card_description: accountData['description'],
            card_balance: accountData['initialPaidOffAmount'],
            goal: accountData['debtGoalAmount'],
            card_icon: Icon(
              IconData(accountData['selectedIcon']),
              color: Color(accountData['selectedColor']),
              size: 45.0,
            ),
            card_color: Color(accountData['selectedColor']),
            progress: (1.0 * accountData['initialPaidOffAmount']) / accountData['debtGoalAmount'],
            type: accountData['selectedType'],
          ),
        );
      });
    }
  }

  void addMoney(MyDebtsAccountCard account, BuildContext context, VoidCallback onComplete) {
    TextEditingController addMoneyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.offWhite,
          title: Text("Add Money"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                textAlign: TextAlign.center,
                style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,
                controller: addMoneyController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              RoundedActionButton(
                function: () {
                  double? amountToAdd = double.tryParse(addMoneyController.text);
                  if (amountToAdd != null && amountToAdd > 0) {
                    double newBalance = account.card_balance + amountToAdd;
                    DebtsAccountStorage.updateBalance({
                      'accountName': account.card_title,
                      'description': account.card_description,
                      'initialPaidOffAmount': newBalance,
                      'debtGoalAmount': account.goal,
                      'selectedIcon': account.card_icon.icon?.codePoint,
                      // ignore: deprecated_member_use
                      'selectedColor': account.card_color.value,
                      'selectedType' : account.type
                    });
                    Navigator.pop(context);
                    onComplete();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a valid amount.")),
                    );
                  }
                },
                label: "Add",
              ),
            ],
          ),
        );
      },
    );
  }

  void removeMoney(MyDebtsAccountCard account, BuildContext context, VoidCallback onComplete) {
    TextEditingController removeMoneyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.offWhite,
          title: Text("Remove Money"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                textAlign: TextAlign.center,
                style: MoneyBodyTextStyle(color: Colors.black, fontSize: 18).textStyle,
                controller: removeMoneyController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              RoundedActionButton(
                function: () {
                  double? amountToRemove = double.tryParse(removeMoneyController.text);
                  if (amountToRemove != null && amountToRemove > 0) {
                    double newBalance = account.card_balance - amountToRemove;
                    DebtsAccountStorage.updateBalance({
                      'accountName': account.card_title,
                      'description': account.card_description,
                      'initialPaidOffAmount': newBalance,
                      'debtGoalAmount': account.goal,
                      'selectedIcon': account.card_icon.icon?.codePoint,
                      // ignore: deprecated_member_use
                      'selectedColor': account.card_color.value,
                      'selectedType' : account.type
                    });
                    Navigator.pop(context);
                    onComplete();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a valid amount.")),
                    );
                  }
                },
                label: "Remove",
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteAccount(MyDebtsAccountCard account, VoidCallback onComplete) async {
    await DebtsAccountStorage.removeAccount(account.card_title);
    onComplete();
  }

  void accountTap(MyDebtsAccountCard account) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  account.card_title,
                  style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 18).textStyle,
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: formatter.format(account.card_balance),
                            style: MoneyBodyTextStyle(color: Colors.black, fontSize: 21).textStyle,
                          ),
                          TextSpan(
                            text: '   saved',
                            style: NormalBodyTextStyle(color: Colors.black).textStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: formatter.format(account.goal - account.card_balance),
                            style: MoneyBodyTextStyle(color: Colors.black, fontSize: 21).textStyle,
                          ),
                          TextSpan(
                            text: '   to go',
                            style: NormalBodyTextStyle(color: Colors.black).textStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.darkerGray,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    account.card_description.isNotEmpty
                        ? account.card_description
                        : "No description",
                    style: NormalBodyTextStyle(color: Colors.black, fontSize: 14).textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedIconActionButton(
                        function: () {
                          addMoney(account, context, () {
                            Navigator.pop(context);
                            _loadAccounts();
                          });
                        },
                        label: 'Add',
                        color: AppColors.primary),
                    const SizedBox(height: 10),
                    RoundedIconActionButton(
                        function: () {
                          removeMoney(account, context, () {
                            Navigator.pop(context);
                            _loadAccounts();
                          });
                        },
                        label: 'Remove',
                        color: AppColors.primary),
                    const SizedBox(height: 10),
                    RoundedIconActionButtonReversed(
                        function: () {
                          deleteAccount(account, (){
                              Navigator.pop(context);
                          _loadAccounts();
                    });
                        }, label: 'Delete', color: Colors.red),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingAddButton(account_type: 'Debts', function: () => navigateToAddAccountPage(context)),
      ),
      body: debtsAccountsList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No debts added yet",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 16).textStyle,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: debtsAccountsList.length,
                      itemBuilder: (context, index) {
                        if (index < debtsAccountsList.length) {
                          return GestureDetector(
                              onTap: () => accountTap(debtsAccountsList[index]),
                              child: debtsAccountsList[index]);
                        } else {
                          return const SizedBox(height: 100);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
