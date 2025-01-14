import 'package:expense_tracker/myComponents/HomeComponents/AddCategoryButton.dart';
import 'package:expense_tracker/myComponents/HomeComponents/ExpenseCategoryCard.dart';
import 'package:expense_tracker/pages/main_app/accounts/add_category/add_category_page.dart';
import 'package:expense_tracker/styles/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/styles/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      drawer: const Drawer(
        child: Icon(Ionicons.reorder_three_outline),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,       
        elevation: 0,
        title: Text("January 2025", style: BoldHeaderTextStyle(color: Colors.black).textStyle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              ExpenseCategoryCard(category_name: "Car", category_icon: Ionicons.car_sport, category_color: Colors.green),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Health", category_icon: Ionicons.pulse, category_color: Colors.red),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Groceries", category_icon: Ionicons.cart, category_color: Colors.teal),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Clothing", category_icon: Ionicons.shirt, category_color: Colors.brown),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Cafe", category_icon: Ionicons.cafe, category_color: Colors.blueGrey),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Pets", category_icon: Ionicons.paw, category_color: Colors.deepOrange),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Entertainment", category_icon: Ionicons.game_controller, category_color: Colors.blue),
              const SizedBox(
                height: 10,
              ),
              ExpenseCategoryCard(category_name: "Bills", category_icon: Ionicons.mail, category_color: Colors.purpleAccent),
              const SizedBox(
                height: 10,
              ),
              AddCategoryButton(
                function: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Allows customization of the height
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return const FractionallySizedBox(
                        heightFactor: 0.65, // 70% height of the screen
                        child: AddCategoryPage(), // Your modal content
                      );
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}