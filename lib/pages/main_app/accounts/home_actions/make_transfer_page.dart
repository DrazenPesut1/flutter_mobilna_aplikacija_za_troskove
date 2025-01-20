// ignore_for_file: deprecated_member_use

import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/myComponents/HomeComponents/RoundedActionButton.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/from_account.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/to_account.dart';
import 'package:expense_tracker/pages/main_app/storage/account_storage/regular_account_storage.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class MakeTransferPage extends StatefulWidget {
  const MakeTransferPage({super.key});

  @override
  State<MakeTransferPage> createState() => _MakeTransferPage();
}

class _MakeTransferPage extends State<MakeTransferPage> {
  MyRegularAccountCard? chosen_account_from;
  late Icon chosen_account_icon_from;
  String chosen_account_name_from = "---";

  MyRegularAccountCard? chosen_account_to;
  late Icon chosen_account_icon_to;
  String chosen_account_name_to = "---";

  TextEditingController transfer_date_controller = TextEditingController();
  TextEditingController transfer_comment_controller = TextEditingController();
  TextEditingController transfer_amount_controller = TextEditingController();

  VoidCallback? onTransferComplete;

  Icon date_icon = Icon(
    Icons.calendar_month,
    size: 30,
    color: Colors.black,
  );

  DateTime _selectedDate = DateTime.now();
  String selectedDate = 'Pick a date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? _selectedDate;

    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        transfer_date_controller.text = "${_selectedDate.toLocal()}".split(' ')[0];
        selectedDate = "${_selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void chooseFromAccount() async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      elevation: 5,
      isScrollControlled: true,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            ),
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: FromAccount(),
            ),
          );
        }
      );

      if(result != null){
        setState(() {
          chosen_account_from = result;
          chosen_account_name_from = chosen_account_from!.card_title;
          chosen_account_icon_from = chosen_account_from!.card_icon;
        });
      }
    }

    void chooseToAccount(MyRegularAccountCard fromAccount) async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.offWhite,
      elevation: 5,
      isScrollControlled: true,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            ),
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: ToAccount(fromAccount),
            ),
          );
        }
      );

      if(result != null){
        setState(() {
          chosen_account_to = result;
          chosen_account_name_to = chosen_account_to!.card_title;
          chosen_account_icon_to = chosen_account_to!.card_icon;
        });
      }
    }

   @override
void didChangeDependencies() {
  super.didChangeDependencies();

  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

  if (arguments != null) {
    if (arguments['transfer_account'] != null && arguments['transfer_account'] is MyRegularAccountCard) {
      setState(() {
        chosen_account_from = arguments['transfer_account'];
        chosen_account_name_from = chosen_account_from!.card_title;
        chosen_account_icon_from = chosen_account_from!.card_icon;
      });
    }

    if (arguments['onTransferComplete'] != null && arguments['onTransferComplete'] is VoidCallback) {
      onTransferComplete = arguments['onTransferComplete'];
    }
  }
}

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: AppColors.offWhite,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Ionicons.chevron_back),
            iconSize: 30.0,
            ),
            title: Text("Make Transfer", style: BoldHeaderTextStyle(color: Colors.black).textStyle,),
            centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("From", style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: chooseFromAccount,
                      child: Container(
                        height: 80,
                        width: 140,
                        decoration: BoxDecoration(
                          color: AppColors.darkerGray,
                        borderRadius: BorderRadius.circular(18)
                        ),
                        child: Center(
                          child: 
                            Text(chosen_account_name_from)
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Icon(FontAwesomeIcons.anglesRight, size: 35, color: AppColors.textGray,),
                ),
                Column(
                  children: [
                    Text("To", style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle),
                    GestureDetector(
                        onTap: () {
                            if (chosen_account_from == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text("Please select the 'From' account first."),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context); 
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              chooseToAccount(chosen_account_from!);
                            }
                        },
                      child: Container(
                        height: 80,
                        width: 140,
                        decoration: BoxDecoration(
                          color: AppColors.darkerGray,
                        borderRadius: BorderRadius.circular(18)
                        ),
                        child: Center(
                          child: Text(chosen_account_name_to),
                        ),
                      ),
                    )
                  ],
                ),
            ],),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: transfer_comment_controller,
              minLines: 5,
              maxLines: 5,
              decoration: InputDecoration(
                fillColor: AppColors.darkerGray,
                hintText: "Short note...",
                hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 15).textStyle,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(width: 1)),
              )
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
                _selectDate(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkerGray,
                  borderRadius: BorderRadius.circular(18)
                ),
                height: 50,
                width: double.infinity,
                child: Center(child: Text(selectedDate, style: 
                selectedDate == 'Pick a date' ? NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 15).textStyle 
                : BoldBodyTextStyle(color: Colors.black).textStyle,
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
                  controller: transfer_amount_controller,
                  textAlign: TextAlign.center,
                  style: MoneyBodyTextStyle(color: Colors.black, fontSize: 22).textStyle,
                  decoration: InputDecoration(
                  fillColor: AppColors.darkerGray,
                  hintText: "0,00",
                  hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 22).textStyle,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(width: 1)),
                  ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
                    ],
                      ),           
            const SizedBox(
              height: 15,
            ),
            RoundedActionButton(
              label: "Transfer", 
              function: () {
                String amountText = transfer_amount_controller.text;
                double? amount = double.tryParse(amountText);
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )
                      ),
                      elevation: 3,
                      content: Text("The amount has to be greater than 0", style: NormalBodyTextStyle(color: AppColors.offWhite).textStyle,),
                      backgroundColor: AppColors.primary,
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  return;
                } else if(chosen_account_name_from == chosen_account_name_to){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          "The account you transfer to cannot be the same as the account you transfer from.", 
                          style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 16).textStyle,
                        ),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context); 
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  chosen_account_from?.transferMoney(chosen_account_to!, amount);

                  RegularAccountStorage.updateBalance({
                    'accountName' : chosen_account_name_from,
                    'description' : chosen_account_from?.card_description ?? 'some description' ,
                    'initialBalance' : chosen_account_from!.card_balance,
                    'selectedColor' : chosen_account_from!.card_color.value,
                    'selectedIcon' : chosen_account_from!.card_icon.icon?.codePoint
                  });

                  RegularAccountStorage.updateBalance({
                    'accountName' : chosen_account_name_to,
                    'description' : chosen_account_to?.card_description ?? 'some other description',
                    'initialBalance' : chosen_account_to!.card_balance,
                    'selectedColor' : chosen_account_to!.card_color.value,
                    'selectedIcon' : chosen_account_to!.card_icon.icon?.codePoint
                  });

                  Navigator.pop(context);
                  if(onTransferComplete != null){
                    onTransferComplete!();
                  }
                }
              }
            )
          ],),
        ),
      )
    );
  }
}
