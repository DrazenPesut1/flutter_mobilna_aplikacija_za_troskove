import 'package:expense_tracker/myComponents/CategoryCard.dart';
import 'package:expense_tracker/storage/expense_storage/income_storage.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FromCategory extends StatefulWidget {
  const FromCategory({super.key});

  @override
  _FromCategoryState createState() => _FromCategoryState();
}

class _FromCategoryState extends State<FromCategory> {

  List<IncomeCategoryCard> incomeCategoryList = [];

  Future<void> _loadCategories() async {
    List<Map<String, dynamic>> loadedCategoryData = await IncomeStorage.loadCategories();

    setState(() {
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
    });
  }

  void _selectCategory(IncomeCategoryCard category) {
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
      body: incomeCategoryList.isNotEmpty ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: incomeCategoryList.length,
          itemBuilder: (context, index) {
            IncomeCategoryCard category = incomeCategoryList[index];
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
                  "No income category",
                    style: BoldVariableFontTextStyle(color: AppColors.textGray, fontSize: 18).textStyle,
                  ),),
    );
  }
}
