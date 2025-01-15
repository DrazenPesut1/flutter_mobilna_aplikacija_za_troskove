import 'package:expense_tracker/myComponents/HomeComponents/AddCategoryButton.dart';
import 'package:expense_tracker/myComponents/HomeComponents/ExpenseCategoryCard.dart';
import 'package:expense_tracker/myComponents/HomeComponents/HomeActionButton.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_category/add_category_page.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  List<ExpenseCategoryCard> expenseCategoryList = [
    // Predefined categories
    ExpenseCategoryCard(
      category_name: "Car",
      category_icon: Ionicons.car_sport,
      category_color: Colors.green,
    ),
    ExpenseCategoryCard(
      category_name: "Health",
      category_icon: Ionicons.pulse,
      category_color: Colors.red,
    ),
    ExpenseCategoryCard(
      category_name: "Groceries",
      category_icon: Ionicons.cart,
      category_color: Colors.teal,
    ),
    ExpenseCategoryCard(
      category_name: "Clothing",
      category_icon: Ionicons.shirt,
      category_color: Colors.brown,
    ),
    ExpenseCategoryCard(
      category_name: "Cafe",
      category_icon: Ionicons.cafe,
      category_color: Colors.blueGrey,
    ),
    ExpenseCategoryCard(
      category_name: "Pets",
      category_icon: Ionicons.paw,
      category_color: Colors.deepOrange,
    ),
    ExpenseCategoryCard(
      category_name: "Entertainment",
      category_icon: Ionicons.game_controller,
      category_color: Colors.blue,
    ),
    ExpenseCategoryCard(
      category_name: "Bills",
      category_icon: Ionicons.mail,
      category_color: Colors.purpleAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Quick Actions", 
              style: BoldBodyTextStyle(color: Colors.black).textStyle,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeActionButton(
                  const Icon(
                    Icons.arrow_circle_up_rounded,
                    size: 30.0,
                    color: AppColors.primary,
                  ),
                  "Expense",
                  (){}
                ),
                HomeActionButton(
                  const Icon(
                    Icons.arrow_circle_down_rounded,
                    size: 30.0,
                    color: AppColors.primary,
                  ),
                  "Income",
                  (){}
                ),
                HomeActionButton(
                  const Icon(
                    Icons.double_arrow_rounded,
                    size: 30.0,
                    color: AppColors.primary,
                  ),
                  "Transfer",
                  (){}
                ),
                HomeActionButton(
                  const Icon(
                    Icons.category_rounded,
                    size: 30.0,
                    color: AppColors.primary,
                  ),
                  "Category",
                  (){}
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenseCategoryList.length +
                  1, // Add 1 to the item count for the button
              itemBuilder: (context, index) {
                if (index == expenseCategoryList.length) {
                  // This is the last item, render the AddCategoryButton
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AddCategoryButton(
                      function: () async {
                        final result = await showModalBottomSheet(
                          context: context,
                          elevation: 5,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return const FractionallySizedBox(
                              heightFactor: 0.55, // 55% height of the screen
                              child: AddCategoryPage(),
                            );
                          },
                        );

                        // Check if result is not null and add to the list
                        if (result != null) {
                          debugPrint("Category added: $result");
                          setState(() {
                            expenseCategoryList.add(
                              ExpenseCategoryCard(
                                category_name: result['categoryName'],
                                category_icon: result['selectedIcon'],
                                category_color: result['selectedColor'],
                              ),
                            );
                          });
                        }
                      },
                    ),
                  );
                } else {
                  // Render the categories before the button
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: expenseCategoryList[index],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
