import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/pages/main_app/storage/account_storage/regular_account_storage.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToAccount extends StatefulWidget {
  final MyRegularAccountCard fromAccount;
  const ToAccount(this.fromAccount, {super.key});

  @override
  _ToAccountState createState() => _ToAccountState();
}

class _ToAccountState extends State<ToAccount> {

  List<MyRegularAccountCard> regularAccountsList = [];

  Future<void> _loadAccountsExcept() async {
    List<Map<String, dynamic>> loadedAccountsData = await RegularAccountStorage.loadAccountsExcept(widget.fromAccount.card_title);
    setState(() {
      regularAccountsList = loadedAccountsData.map((accountData) {
        return MyRegularAccountCard(
          card_title: accountData['accountName'],
          card_description: accountData['description'],
          card_balance: accountData['initialBalance'],
          card_icon: Icon(
            IconData(accountData['selectedIcon']),
            color: Color(accountData['selectedColor']),
            size: 45.0,
          ),
          card_color: Color(accountData['selectedColor']),
        );
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
  _loadAccountsExcept();
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
      body: regularAccountsList.isNotEmpty ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: regularAccountsList.length,
          itemBuilder: (context, index) {
            if(regularAccountsList.isNotEmpty){
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
            } else {
              return Center(child: Text("No other account to transfer to", style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 18).textStyle,),);
            }
          },
        ),
      ) : Center(child: 
        Text(
                  "No account to transfer to",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 18).textStyle,
                  ),),
    );
  }
}
