// ignore_for_file: deprecated_member_use

import 'package:expense_tracker/myComponents/CategoryCard.dart';
import 'package:expense_tracker/myComponents/HomeActionButton.dart';
import 'package:expense_tracker/myComponents/AccountCard.dart';
import 'package:expense_tracker/myComponents/AccountActionButtonReversed.dart';
import 'package:expense_tracker/storage/expense_storage/expense_storage.dart';
import 'package:expense_tracker/storage/account_storage/regular_account_storage.dart';
import 'package:expense_tracker/storage/expense_storage/income_storage.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ExpenseHomePage extends StatefulWidget {
  final Function(double)? onBalanceUpdated; 
  const ExpenseHomePage(this.onBalanceUpdated, {super.key});

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  List<ExpenseCategoryCard> predefinedCategoryList = [
    ExpenseCategoryCard(
      category_name: "Health",
      category_icon: FontAwesomeIcons.heartCrack,
      category_color: Colors.red,
    ),
    ExpenseCategoryCard(
      category_name: "Groceries",
      category_icon: FontAwesomeIcons.cartShopping,
      category_color: Colors.blueAccent,
    ),
    ExpenseCategoryCard(
      category_name: "Cafe",
      category_icon: FontAwesomeIcons.mugSaucer,
      category_color: Colors.brown,
    ),
    ExpenseCategoryCard(
      category_name: "Transportation",
      category_icon: FontAwesomeIcons.bus,
      category_color: Colors.orange,
    ),
    ExpenseCategoryCard(
      category_name: "Car",
      category_icon: FontAwesomeIcons.carSide,
      category_color: Colors.green,
    ),
    ExpenseCategoryCard(
      category_name: "Entertainment",
      category_icon: FontAwesomeIcons.film,
      category_color: Colors.deepPurpleAccent,
    ),
  ];

  late double total_balance;
  double total_expenses = 0;
  double total_incomes = 0;
  
  NumberFormat formatter = NumberFormat.currency(locale: "de_DE", decimalDigits: 2);

  Future<void> _loadTotalExpenses() async {
      total_expenses = await ExpenseStorage.loadTotalExpenses();
  setState(() {});
  }

  Future<void> _loadTotalIncome() async {
      total_incomes = await IncomeStorage.loadTotalIncome();
  setState(() {});
  }

  List<ExpenseCategoryCard> expenseCategoryList = [];

  Future<void> _savePredefinedCategories() async {
    for (ExpenseCategoryCard predefinedCategory in predefinedCategoryList) {
      await ExpenseStorage.saveCategories({
        "categoryName": predefinedCategory.category_name,
        "categoryIcon": predefinedCategory.category_icon.codePoint,
        "categoryIconFamily" : predefinedCategory.category_icon.fontFamily,
        "categoryColor": predefinedCategory.category_color.value,
        "categoryExpense": 0.0,
      });
    }

    debugPrint('Called predefined categories');
  }

  Future<void> _loadCategories() async {
  List<Map<String, dynamic>> loadedCategoryData = await ExpenseStorage.loadCategories();
  expenseCategoryList = loadedCategoryData.map((categoryData) {
      return ExpenseCategoryCard(
        category_name: categoryData['categoryName'],
        category_icon: IconData(
          categoryData['categoryIcon'], fontFamily: categoryData['categoryIconFamily'], fontPackage: 'font_awesome_flutter' 
        ),
        category_color: Color(categoryData['categoryColor']),
        category_expense: categoryData['categoryExpense'] ?? 0.0,
      );
    }).toList();

    setState(() {});
    debugPrint(expenseCategoryList.length.toString());
}

List<IncomeCategoryCard> incomeCategoryList = [];

Future<void> _loadIncomeCategories() async {
  List<Map<String, dynamic>> loadedCategoryData = await IncomeStorage.loadCategories();
  incomeCategoryList = loadedCategoryData.map((categoryData) {
      return IncomeCategoryCard(
        category_name: categoryData['categoryName'],
        category_icon: IconData(
          categoryData['categoryIcon'], fontFamily: categoryData['categoryIconFamily'], fontPackage: 'font_awesome_flutter'  
        ),
        category_color: Color(categoryData['categoryColor']),
        category_income: categoryData['categoryIncome'] ?? 0.0,
      );
    }).toList();

    setState(() {});
    debugPrint(incomeCategoryList.length.toString());
}

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
            size: 45.0,
          ),
          card_color: Color(accountData['selectedColor']),
        );
      }).toList();
    });
  }

  void addExpense() async {
    final result = await Navigator.pushNamed(context, '/add_expense_page');

    if(result != null){
      Map<String, dynamic> expenseData = result as Map<String,dynamic>;

      late ExpenseCategoryCard found_category;
      late MyRegularAccountCard found_account_card;

      for(MyRegularAccountCard account in regularAccountsList){
        if(account.card_title == expenseData['expenseAccount'].card_title){
          found_account_card = account;
        }
      }

      found_account_card.card_balance = expenseData['expenseAccount'].card_balance;

      await RegularAccountStorage.updateBalance({
        'accountName': found_account_card.card_title,
        'description': found_account_card.card_description,
        'initialBalance': found_account_card.card_balance,
        'selectedIcon': found_account_card.card_icon.icon?.codePoint,
        'selectedIconFamily': found_account_card.card_icon.icon?.fontFamily,
        'selectedColor': found_account_card.card_color.value
      });

      for(ExpenseCategoryCard expenseCategory in expenseCategoryList){
        if(expenseCategory.category_name == expenseData['expenseCategory'].category_name){
          found_category = expenseCategory;
        }
      }

      found_category.category_expense = expenseData['expenseCategory'].category_expense;

      await ExpenseStorage.updateCategory({
        "categoryName": found_category.category_name,
        "categoryIcon": found_category.category_icon.codePoint,
        'categoryIconFamily': found_category.category_icon.fontFamily,
        "categoryColor": found_category.category_color.value,
        "categoryExpense": found_category.category_expense,
      });

      await ExpenseStorage.saveTotalExpenses(total_expenses += expenseData['expenseAmount']);

      total_balance = await RegularAccountStorage.loadTotalBalance();
      await RegularAccountStorage.saveTotalBalance(total_balance -= expenseData['expenseAmount']);

       if (widget.onBalanceUpdated != null) {
          widget.onBalanceUpdated!(total_balance);
    }

      _loadCategories();
    }
  }

  void addIncome() async {
    final result = await Navigator.pushNamed(context, '/add_income_page');

    if(result != null){
      Map<String, dynamic> incomeData = result as Map<String,dynamic>;

      late IncomeCategoryCard found_category;
      late MyRegularAccountCard found_account_card;

      for(MyRegularAccountCard account in regularAccountsList){
        if(account.card_title == incomeData['incomeAccount'].card_title){
          found_account_card = account;
        }
      }

      found_account_card.card_balance = incomeData['incomeAccount'].card_balance;

      await RegularAccountStorage.updateBalance({
        'accountName': found_account_card.card_title,
        'description': found_account_card.card_description,
        'initialBalance': found_account_card.card_balance,
        'selectedIcon': found_account_card.card_icon.icon?.codePoint,
        'selectedIconFamily': found_account_card.card_icon.icon?.fontFamily,
        'selectedColor': found_account_card.card_color.value
      });

      for(IncomeCategoryCard incomeCategory in incomeCategoryList){
        if(incomeCategory.category_name == incomeData['incomeCategory'].category_name){
          found_category = incomeCategory;
        }
      }

      found_category.category_income = incomeData['incomeCategory'].category_income;

      await IncomeStorage.updateCategory({
        "categoryName": found_category.category_name,
        "categoryIcon": found_category.category_icon.codePoint,
        'categoryIconFamily': found_category.category_icon.fontFamily,
        "categoryColor": found_category.category_color.value,
        "categoryIncome": found_category.category_income,
      });

      await IncomeStorage.saveTotalIncome(total_incomes += incomeData['incomeAmount']);

      total_balance = await RegularAccountStorage.loadTotalBalance();
      await RegularAccountStorage.saveTotalBalance(total_balance += incomeData['incomeAmount']);

       if (widget.onBalanceUpdated != null) {
          widget.onBalanceUpdated!(total_balance);
    }

      _loadCategories();
    }
  }
  void makeTransfer() {
    Navigator.pushNamed(context, '/make_transfer_page');
  }

  void addCategory() async {
    final result = await Navigator.pushNamed(context, '/add_category_page');

    if (result != null) {
      final Map<String, dynamic> categoryData = result as Map<String, dynamic>; 

      if(categoryData['categoryType'] == 'Expense'){
        ExpenseStorage.saveCategories(categoryData);

        setState(() {
        expenseCategoryList.add(
          ExpenseCategoryCard(
            category_name: categoryData['categoryName'],
            category_icon: IconData(
              categoryData['categoryIcon'], fontFamily: categoryData['categoryIconFamily'], fontPackage: 'font_awesome_flutter'
            ),
            category_color: Color(categoryData['categoryColor']),
            category_expense: categoryData['categoryExpense'],
          ),
        );
      });
      } else {
        IncomeStorage.saveCategories(categoryData);
      }
      }
    }

  Future<void> shouldIloadPredefinedCategories() async {
    bool value = await ExpenseStorage.loadPredefinedCategories();

    if(!value){
      await _savePredefinedCategories();
    }
  } 

  void deleteCategory(ExpenseCategoryCard category, VoidCallback onComplete) async {
    await ExpenseStorage.saveTotalExpenses(total_expenses -= category.category_expense);
    await ExpenseStorage.removeCategory(category.category_name);
    onComplete();
  }

  void expenseCategoryTap(ExpenseCategoryCard category) {
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
                category.category_name,
                style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 18).textStyle,
              ),
              const SizedBox(height: 8.0),
              Text(formatter.format(category.category_expense), 
                  style: MoneyBodyTextStyle(color: Colors.black, fontSize: 23).textStyle),
              const SizedBox(height: 8.0),
              AccountActionButtonReversed(
                function: () {
                  deleteCategory(category, (){
                    Navigator.pop(context);
                    _loadCategories();
                  });
                },
                label: 'Delete',
                color: Colors.red,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  void initState(){
    super.initState();
    shouldIloadPredefinedCategories();
    _loadCategories();
    _loadIncomeCategories();
    _loadAccounts();
    _loadTotalExpenses();
    _loadTotalIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.darkerGray,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total expenses", style: NormalVariableFontTextStyle(color: Colors.black, fontSize: 14).textStyle),
                  Text(
                    formatter.format(total_expenses),
                    style: MoneyBodyTextStyle(color: AppColors.moneyNegative, fontSize: 24).textStyle,),
                ],
              ),
            ),
            const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Operations", 
              style: BoldVariableFontTextStyle(color: Colors.black, fontSize: 17).textStyle,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeActionButton(
                const Icon(
                  FontAwesomeIcons.circleDollarToSlot,
                  size: 30.0,
                  color: AppColors.moneyNegative,
                ),
                "Expense",
                addExpense,
              ),
              HomeActionButton(
                const Icon(
                  FontAwesomeIcons.handHoldingDollar,
                  size: 30.0,
                  color: AppColors.moneyPositive,
                ),
                "Income",
                addIncome,
              ),
              HomeActionButton(
                const Icon(
                  FontAwesomeIcons.moneyBillTransfer,
                  size: 30.0,
                  color: AppColors.primary,
                ),
                "Transfer",
                makeTransfer,
              ),
              HomeActionButton(
                const Icon(
                  Icons.category_rounded,
                  size: 30.0,
                  color: Colors.orange,
                ),
                "Category",
                addCategory,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Categories", 
            style: BoldVariableFontTextStyle(
              color: Colors.black, fontSize: 17).textStyle,
            )),
             const SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: expenseCategoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      expenseCategoryTap(expenseCategoryList[index]);
                    },
                    child: expenseCategoryList[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
