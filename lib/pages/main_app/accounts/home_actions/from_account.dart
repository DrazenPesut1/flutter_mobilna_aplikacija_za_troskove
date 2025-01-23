import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/pages/main_app/storage/account_storage/regular_account_storage.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FromAccount extends StatefulWidget {
  const FromAccount({super.key});

  @override
  _FromAccountState createState() => _FromAccountState();
}

class _FromAccountState extends State<FromAccount> {

  List<MyRegularAccountCard> regularAccountsList = [];

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
            color: Color(accountData['selectedColor']),
            size: 35.0,
          ),
          card_color: Color(accountData['selectedColor']),
        );
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  void _selectAccount(MyRegularAccountCard account) {
    Navigator.pop(context, account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          backgroundColor: AppColors.offWhite,
          automaticallyImplyLeading: false,
          title: Icon(FontAwesomeIcons.minus, size: 30, color: Colors.black,),
          centerTitle: true,
        )),
      backgroundColor: AppColors.offWhite,
      body: regularAccountsList.isNotEmpty ?  
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: regularAccountsList.length,
          itemBuilder: (context, index) {
            MyRegularAccountCard account = regularAccountsList[index];
            return GestureDetector(
              onTap: () {
                _selectAccount(account);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: account,
              ),
            );
          },
        ),
      ) : Center(
        child: Text(
                  "No accounts added yet",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 18).textStyle,
                  ),
      ),
    );
  }
}
