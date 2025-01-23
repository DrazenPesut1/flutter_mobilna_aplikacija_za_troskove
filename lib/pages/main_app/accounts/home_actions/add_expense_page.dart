import 'package:expense_tracker/myComponents/HomeComponents/CategoryCard.dart';
import 'package:expense_tracker/myComponents/HomeComponents/RoundedActionButton.dart';
import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/from_account.dart';
import 'package:expense_tracker/pages/main_app/accounts/home_actions/to_category.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePage();
}

class _AddExpensePage extends State<AddExpensePage> {
  late MyRegularAccountCard chosen_account;
  late Icon chosen_account_icon;
  String chosen_account_name = "---";

  late ExpenseCategoryCard chosen_category;
  late IconData chosen_category_icon;
  String chosen_category_name = "---";

  TextEditingController expense_date_controller = TextEditingController();
  TextEditingController expense_comment_controller = TextEditingController();
  TextEditingController expense_amount_controller = TextEditingController();

  Icon date_icon = Icon(
    Icons.calendar_month,
    size: 33,
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
        ) ??
        _selectedDate;

    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        expense_date_controller.text = "${_selectedDate.toLocal()}".split(' ')[0];
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
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: FromAccount(),
            ),
          );
        });

    if (result != null) {
      setState(() {
        chosen_account = result;
        chosen_account_name = chosen_account.card_title;
        chosen_account_icon = chosen_account.card_icon;
      });
    }
  }

  void chooseToCategory() async {
    final result = await showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: ToCategory(),
            ),
          );
        });

    if (result != null) {
      setState(() {
        chosen_category = result;
        chosen_category_name = chosen_category.category_name;
        chosen_category_icon = chosen_category.category_icon;
      });
    }
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Ionicons.chevron_back),
            iconSize: 30.0,
          ),
          title: Text(
            "Add Expense",
            style: BoldHeaderTextStyle(color: Colors.black).textStyle,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "From",
                        style: BoldBodyTextStyle(color: Colors.black).textStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: chooseFromAccount,
                        child: Container(
                          height: 60,
                          width: 160,
                          decoration: BoxDecoration(
                              color: AppColors.darkerGray,
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                            child: Text(
                                chosen_account_name,
                                style: BoldVariableFontTextStyle(
                                        color: Colors.black, fontSize: 15)
                                    .textStyle),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Icon(
                      Ionicons.arrow_forward,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "To",
                        style: BoldBodyTextStyle(color: Colors.black).textStyle,
                      ),
                      GestureDetector(
                        onTap: chooseToCategory,
                        child: Container(
                          height: 60,
                          width: 160,
                          decoration: BoxDecoration(
                              color: AppColors.darkerGray,
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                            child: Text(
                              chosen_category_name,
                              style: BoldVariableFontTextStyle(
                                      color: Colors.black, fontSize: 15)
                                  .textStyle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  controller: expense_comment_controller,
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: AppColors.darkerGray,
                    hintText: "Short note...",
                    hintStyle: NormalVariableFontTextStyle(
                            color: AppColors.textGray, fontSize: 15)
                        .textStyle,
                    filled: true,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        borderSide: BorderSide(width: 1)),
                  )),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.darkerGray,
                      borderRadius: BorderRadius.circular(18)),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    selectedDate,
                    style: selectedDate == 'Pick a date'
                        ? NormalVariableFontTextStyle(
                                color: AppColors.textGray, fontSize: 15)
                            .textStyle
                        : BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,
                  )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: expense_amount_controller,
                textAlign: TextAlign.center,
                style: MoneyBodyTextStyle(color: Colors.black, fontSize: 22)
                    .textStyle,
                decoration: InputDecoration(
                  fillColor: AppColors.darkerGray,
                  hintText: "0,00",
                  hintStyle: NormalVariableFontTextStyle(
                          color: AppColors.textGray, fontSize: 22)
                      .textStyle,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(width: 1)),
                ),
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+(\.\d{0,2})?$')),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedActionButton(
                  label: "Add",
                  function: () {
                    String amountText = expense_amount_controller.text;
                    double? amount = double.tryParse(amountText);

                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 1,
                          content: Text(
                            "The amount has to be greater than 0",
                            style: NormalBodyTextStyle(color: Colors.black)
                                .textStyle,
                          ),
                          backgroundColor: AppColors.offWhite,
                        ),
                      );
                      return;
                    }

                    chosen_account.card_balance -= amount;
                    chosen_category.category_expense += amount;

                    final expenseData = {
                      "expenseAccount": chosen_account,
                      "expenseCategory": chosen_category,
                      "expenseAmount": amount
                    };

                    Navigator.pop(context, expenseData);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
