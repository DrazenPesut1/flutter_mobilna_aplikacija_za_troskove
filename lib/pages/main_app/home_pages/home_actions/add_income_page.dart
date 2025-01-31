import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/myComponents/CategoryCard.dart';
import 'package:expense_tracker/myComponents/RoundedActionButton.dart';
import 'package:expense_tracker/pages/main_app/home_pages/home_actions/from_account.dart';
import 'package:expense_tracker/pages/main_app/home_pages/home_actions/from_category.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePage();
}

class _AddIncomePage extends State<AddIncomePage> {
  late MyRegularAccountCard chosen_account;
  Icon chosen_account_icon = Icon(
    Ionicons.card,
    size: 33,
    color: Colors.red,
  );
  String chosen_account_name = "---";

  late IncomeCategoryCard chosen_category;
  late IconData chosen_category_icon;
  String chosen_category_name = "---";

  TextEditingController income_date_controller = TextEditingController();
  TextEditingController income_comment_controller = TextEditingController();
  TextEditingController income_amount_controller = TextEditingController();

  String selectedDate = 'Pick a date';
  DateTime _selectedDate = DateTime.now();

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
        income_date_controller.text = "${_selectedDate.toLocal()}".split(' ')[0];
        selectedDate = "${_selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void chooseFromCategory() async {
    final result = await showModalBottomSheet(
      context: context,
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
              child: FromCategory(),
            ),
          );
        }
      );

      if(result != null){
        setState(() {
          chosen_category = result;
          chosen_category_name = chosen_category.category_name;
          chosen_category_icon = chosen_category.category_icon;
        });
      }
    }

    void chooseToAccount() async {
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
          chosen_account = result;
          chosen_account_name = chosen_account.card_title;
          chosen_account_icon = chosen_account.card_icon;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: AppColors.offWhite,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Ionicons.chevron_back),
            iconSize: 30.0,
          ),
          title: Text(
            "Add Income",
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
                        style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: chooseFromCategory,
                        child: Container(
                          height: 60,
                          width: 160,
                          decoration: BoxDecoration(
                            color: AppColors.darkerGray,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Text(
                              chosen_category_name,
                              style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25),
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
                        style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: chooseToAccount,
                        child: Container(
                          height: 60,
                          width: 160,
                          decoration: BoxDecoration(
                            color: AppColors.darkerGray,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Text(
                              chosen_account_name,
                              style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: income_comment_controller,
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: AppColors.darkerGray,
                  hintText: "Short note...",
                  hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 15).textStyle,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
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
                    borderRadius: BorderRadius.circular(18),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      selectedDate,
                      style: selectedDate == 'Pick a date'
                          ? NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 15).textStyle
                          : BoldVariableFontTextStyle(color: Colors.black, fontSize: 15).textStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: income_amount_controller,
                textAlign: TextAlign.center,
                style: MoneyBodyTextStyle(color: Colors.black, fontSize: 22).textStyle,
                decoration: InputDecoration(
                  fillColor: AppColors.darkerGray,
                  hintText: "0,00",
                  hintStyle: NormalVariableFontTextStyle(color: AppColors.textGray, fontSize: 22).textStyle,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(width: 1),
                  ),
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
                label: "Add", 
              function: () {
                String amountText = income_amount_controller.text;
                double? amount = double.tryParse(amountText);
            
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 1,
                      content: Text("The amount has to be greater than 0", style: NormalBodyTextStyle(color: Colors.black).textStyle,),
                      backgroundColor: AppColors.offWhite,
                    ),
                  );
                  return; 
                }
                        
                chosen_account.card_balance += amount;
                chosen_category.category_income += amount;
            
                final expenseData = {
                  "incomeAccount" : chosen_account,
                  "incomeCategory" : chosen_category,
                  "incomeAmount" : amount
                };
            
                Navigator.pop(context, expenseData);
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
