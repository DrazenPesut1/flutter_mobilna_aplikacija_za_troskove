import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseStorage {
  static const String _expenseCategoriesKey = 'expense_categories_list';

  static Future<void> saveCategories(Map<String, dynamic> categoryData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_expenseCategoriesKey);
    categoriesList ??= [];
    String categoryJson = json.encode(categoryData);
    categoriesList.add(categoryJson);
    await prefs.setStringList(_expenseCategoriesKey, categoriesList);
  }

  static Future<List<Map<String, dynamic>>> loadCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_expenseCategoriesKey);
    if (categoriesList == null) {
      return [];
    }
    return categoriesList.map((categoryJson) {
      return json.decode(categoryJson) as Map<String, dynamic>;
    }).toList();
  }

  static Future<void> updateCategory(Map<String, dynamic> updatedCategoryData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_expenseCategoriesKey);
    if (categoriesList == null) {
      return;
    }
    int categoryIndex = categoriesList.indexWhere((categoryJson) {
      Map<String, dynamic> categoryData = json.decode(categoryJson);
      return categoryData['categoryName'] == updatedCategoryData['categoryName'];
    });
    if (categoryIndex != -1) {
      categoriesList[categoryIndex] = json.encode(updatedCategoryData);
      await prefs.setStringList(_expenseCategoriesKey, categoriesList);
    }
  }

  static const String predef_key = 'predef_key_true';

  static Future<void> savePredefinedCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(predef_key, true);
  }

  static Future<bool> loadPredefinedCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool predef = prefs.getBool(predef_key) ?? false;
    if(predef == false){
      savePredefinedCategories();
      return false;
    } else {
      return true;
    }
  }

  static Future<void> removeCategory(String categoryName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_expenseCategoriesKey);
    if (categoriesList == null || categoriesList.isEmpty) {
      return;
    }
    int categoryIndex = categoriesList.indexWhere((categoryJson) {
      Map<String, dynamic> categoryData = json.decode(categoryJson);
      return categoryData['categoryName'] == categoryName;
    });
    if (categoryIndex != -1) {
      categoriesList.removeAt(categoryIndex);
      await prefs.setStringList(_expenseCategoriesKey, categoriesList);
    }
  }

  static const String _totalExpensesKey = 'total_expenses_key';

  static Future<double> loadTotalExpenses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_totalExpensesKey) ?? 0.0;
  }

  static Future<void> saveTotalExpenses(double totalExpenses) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_totalExpensesKey, totalExpenses);
  }

  static Future<void> clearCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_expenseCategoriesKey);
  }
}
