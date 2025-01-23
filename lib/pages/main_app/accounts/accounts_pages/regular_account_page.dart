import 'package:expense_tracker/myComponents/HomeComponents/RoundedActionButton.dart';
import 'package:expense_tracker/myComponents/RoundedIconActionButtonReversed.dart';
import 'package:expense_tracker/myComponents/RoundedIconActionButton.dart';
import 'package:expense_tracker/pages/main_app/storage/account_storage/regular_account_storage.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/myComponents/FloatingAddButton.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RegularAccountPage extends StatefulWidget {
  const RegularAccountPage({super.key});

  @override
  State<RegularAccountPage> createState() => _RegularAccountPageState();
}

class _RegularAccountPageState extends State<RegularAccountPage> {
  NumberFormat formatter = NumberFormat.currency(locale: "de_DE", decimalDigits: 2);
  double total_balance = 0;
  String currency = 'EUR';
  List<MyRegularAccountCard> regularAccountsList = [];

  @override
  void initState() {
    super.initState();
    _loadAccounts();
    _loadTotalBalance();
  }

  Future<void> _loadTotalBalance() async {
    total_balance = await RegularAccountStorage.loadTotalBalance();
    setState(() {});
  }

  Future<void> _saveTotalBalance() async {
    await RegularAccountStorage.saveTotalBalance(total_balance);
  }

  Future<void> _loadAccounts() async {
    List<Map<String, dynamic>> loadedAccountsData = await RegularAccountStorage.loadAccounts();
    setState(() {
      regularAccountsList = loadedAccountsData.map((accountData) {

        return MyRegularAccountCard(
          card_title: accountData['accountName'],
            card_description: accountData['description'],
            card_balance: accountData['initialBalance'],
            card_icon: Icon(
              IconData(accountData['selectedIcon'], fontFamily: accountData['selectedIconFamily'], fontPackage: 'font_awesome_flutter'), 
              size: 35, 
              color: Color(accountData['selectedColor']),
            ),
            card_color: Color(accountData['selectedColor']),
        );
      }).toList();
    });
  }

  void navigateToAddAccountPage(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      '/add_regular_account_page'
    );

    if (result != null) {
      final Map<String, dynamic> accountData = result as Map<String, dynamic>;
      setState(() {
        total_balance += accountData['initialBalance'];  // Update the total balance
      });

      _saveTotalBalance();  

      RegularAccountStorage.saveAccount(accountData);

      setState(() {
        regularAccountsList.add(
          MyRegularAccountCard(
            card_title: accountData['accountName'],
            card_description: accountData['description'],
            card_balance: accountData['initialBalance'],
            card_icon: Icon(
              IconData(accountData['selectedIcon'], fontFamily: accountData['selectedIconFamily'], fontPackage: 'font_awesome_flutter'), 
              size: 35, 
              color: Color(accountData['selectedColor']),
            ),
            card_color: Color(accountData['selectedColor']),
          ),
        );
      });
    }
  }

  void editAccount(MyRegularAccountCard account, context, VoidCallback onComplete) async {
      
      final result = await Navigator.pushNamed(
        context,
      '/edit_regular_account_page', arguments: account);
    
      total_balance -= account.card_balance;
    
    if (result != null) {
      Map<String, dynamic> accountData = result as Map<String, dynamic>;

      setState(() {
        total_balance += accountData['initialBalance'];
      });
      
      _saveTotalBalance();

      debugPrint(accountData['accountName'].toString());
      accountData['oldAccountName'] = account.card_title;
      await RegularAccountStorage.editAccount(accountData);

      Navigator.pop(context);
      onComplete();
    }
  
  }

  
  void addMoney(MyRegularAccountCard account, BuildContext context, VoidCallback onComplete) {
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
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Accept decimal numbers
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')), // Limit decimal precision
              ],
            ),
            const SizedBox(height: 20),
            RoundedActionButton(
              function: () {
                double? amountToAdd = double.tryParse(addMoneyController.text);

                if (amountToAdd != null && amountToAdd > 0) {
                  double newBalance = account.card_balance + amountToAdd;

                  RegularAccountStorage.updateBalance({
                    'accountName': account.card_title,
                    'description': account.card_description,
                    'initialBalance': newBalance,
                    'selectedIcon': account.card_icon.icon?.codePoint,
                    'selectedIconFamily' : account.card_icon.icon?.fontFamily,
                    // ignore: deprecated_member_use
                    'selectedColor': account.card_color.value,
                  });

                  total_balance += amountToAdd;
                  RegularAccountStorage.saveTotalBalance(total_balance);

                  debugPrint("New account balance - ${account.card_title} : $newBalance");

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


  removeMoney(MyRegularAccountCard account, BuildContext context, VoidCallback onComplete) {
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
              keyboardType: TextInputType.numberWithOptions(decimal: true), // Accept decimal numbers
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 14).textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')), // Limit decimal precision
              ],
            ),
            const SizedBox(height: 20),
            RoundedActionButton(
              function: () {
                double? amountToAdd = double.tryParse(removeMoneyController.text);

                if (amountToAdd != null && amountToAdd > 0) {
                  double newBalance = account.card_balance - amountToAdd;

                  RegularAccountStorage.updateBalance({
                    'accountName': account.card_title,
                    'description': account.card_description,
                    'initialBalance': newBalance,
                    'selectedIcon': account.card_icon.icon?.codePoint,
                    'selectedIconFamily' : account.card_icon.icon?.fontFamily,
                    // ignore: deprecated_member_use
                    'selectedColor': account.card_color.value,
                  });

                  total_balance -= amountToAdd;
                  RegularAccountStorage.saveTotalBalance(total_balance);

                  debugPrint("New account balance - ${account.card_title} : $newBalance");

                  Navigator.pop(context);  // Close the dialog
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

  void deleteAccount(MyRegularAccountCard account, context, VoidCallback onComplete) async {
    await RegularAccountStorage.saveTotalBalance(total_balance -= account.card_balance); 
    await RegularAccountStorage.removeAccount(account.card_title);
    onComplete();
  }


  void accountTap(MyRegularAccountCard account) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.offWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(40.0), // Rounded top corners
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
              const SizedBox(height: 8.0),
              Text(formatter.format(account.card_balance), style: MoneyBodyTextStyle(color: Colors.black, fontSize: 23).textStyle),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.darkerGray,  
                    borderRadius: BorderRadius.circular(18),  
                  ),
                  child: account.card_description != '' ? Text(
                    account.card_description,
                    style: NormalBodyTextStyle(color: Colors.black, fontSize: 14).textStyle,
                    textAlign: TextAlign.center,
                  ) : Text("No description", style: NormalBodyTextStyle(color: Colors.black, fontSize: 14).textStyle,
                    textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedIconActionButton(function: (){
                    editAccount(account, context, () {
                      _loadAccounts();  
                    });
                  }, label: 'Edit', color: AppColors.primary),
                  SizedBox(
                    height: 10,
                  ),
                  RoundedIconActionButton(function: (){
                    addMoney(account, context, () {
                      Navigator.pop(context);
                      _loadAccounts(); 
                    });
                  }, label: 'Add', color: AppColors.primary),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedIconActionButton(function: (){
                    removeMoney(account, context, (){
                      Navigator.pop(context);
                      _loadAccounts();
                    });
                  }, label: 'Remove', color: AppColors.primary,),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedIconActionButton(function: (){
                      Navigator.pushNamed(context, '/make_transfer_page', 
                      arguments: {
                        'transfer_account' : account,
                        'onTransferComplete' : (){
                          Navigator.pop(context);
                          _loadAccounts();
                        }
                      });
                  }, label: 'Transfer', color: AppColors.primary,),
                  const SizedBox(
                    height: 10,
                  ),
                  RoundedIconActionButtonReversed(function: (){
                    deleteAccount(account, context, (){
                      Navigator.pop(context);
                      _loadAccounts();
                    });
                  }, label: 'Delete', color: Colors.red,),
                  const SizedBox(
                    height: 10,
                  ),
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
    floatingActionButton: FloatingAddButton(
      account_type: 'Regular', 
      function: () => navigateToAddAccountPage(context)
    ),
    backgroundColor: AppColors.offWhite, 
    body: regularAccountsList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    "No regular account added yet",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 16).textStyle,
                  ),
                  SizedBox(height: 8), 
                  Text(
                    "Added accounts will appear here",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 16).textStyle,
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Total account balance", 
                      style: NormalBodyTextStyle(color: Colors.black).textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      formatter.format(total_balance),
                      style: MoneyBodyTextStyle(color: Colors.black, fontSize: 24).textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: regularAccountsList.length + 1, 
                      itemBuilder: (context, index) {
                        if (index < regularAccountsList.length) {
                          return GestureDetector(
                            onTap: () => accountTap(regularAccountsList[index]),
                            child: regularAccountsList[index]
                          );
                        } else {
                          return SizedBox(height: 100);
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
