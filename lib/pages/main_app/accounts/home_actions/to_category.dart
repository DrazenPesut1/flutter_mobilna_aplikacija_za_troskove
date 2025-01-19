import 'package:expense_tracker/myComponents/HomeComponents/CategoryCard.dart';
import 'package:expense_tracker/pages/main_app/storage/expense_storage/expense_storage.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToCategory extends StatefulWidget {
  const ToCategory({super.key});

  @override
  _ToCategoryState createState() => _ToCategoryState();
}

class _ToCategoryState extends State<ToCategory> {

  List<ExpenseCategoryCard> expenseCategoryList = [];

  Future<void> _loadCategories() async {
    List<Map<String, dynamic>> loadedCategoryData = await ExpenseStorage.loadCategories();

    setState(() {
      expenseCategoryList = loadedCategoryData.map((categoryData) {
      return ExpenseCategoryCard(
        category_name: categoryData['categoryName'],
        category_icon: IconData(
          categoryData['categoryIcon'], 
        ),
        category_color: Color(categoryData['categoryColor']),
        category_expense: categoryData['categoryExpense'] ?? 0.0,
      );
    }).toList();
    });
  }

  void _selectCategory(ExpenseCategoryCard category) {
    Navigator.pop(context, category);
  }

  @override
  void initState() {
    super.initState();
    _loadCategories(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          backgroundColor: AppColors.offWhite,
          automaticallyImplyLeading: false,
          title: Icon(FontAwesomeIcons.minus, size: 30, color: Colors.black,),
          centerTitle: true,
        ),
      ),
      body: expenseCategoryList.isNotEmpty? Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: expenseCategoryList.length,
          itemBuilder: (context, index) {
            ExpenseCategoryCard category = expenseCategoryList[index];
            return GestureDetector(
              onTap: () {
                _selectCategory(category);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: category,
              ),
            );
          },
        ),
      ) : Center(child: Text(
                  "No expense category created",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 18).textStyle,
                  ),),
    );
  }
}
