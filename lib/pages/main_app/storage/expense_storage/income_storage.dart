import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeStorage {
  static const String _incomeCategoriesKey = 'income_categories_list';

  static Future<void> saveCategories(Map<String, dynamic> categoryData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_incomeCategoriesKey);
    categoriesList ??= [];
    String categoryJson = json.encode(categoryData);
    categoriesList.add(categoryJson);
    await prefs.setStringList(_incomeCategoriesKey, categoriesList);
  }

  static Future<List<Map<String, dynamic>>> loadCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_incomeCategoriesKey);
    if (categoriesList == null) {
      return [];
    }
    return categoriesList.map((categoryJson) {
      return json.decode(categoryJson) as Map<String, dynamic>;
    }).toList();
  }

  static Future<void> updateCategory(Map<String, dynamic> updatedCategoryData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_incomeCategoriesKey);
    if (categoriesList == null) {
      return;
    }
    int categoryIndex = categoriesList.indexWhere((categoryJson) {
      Map<String, dynamic> categoryData = json.decode(categoryJson);
      return categoryData['categoryName'] == updatedCategoryData['categoryName'];
    });
    if (categoryIndex != -1) {
      categoriesList[categoryIndex] = json.encode(updatedCategoryData);
      await prefs.setStringList(_incomeCategoriesKey, categoriesList);
    }
  }

  static const String predef_key_income = 'predef_key_true_income';

  static Future<void> savePredefinedCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(predef_key_income, true);
  }

  static Future<bool> loadPredefinedCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool predef = prefs.getBool(predef_key_income) ?? false;
    if (predef == false) {
      savePredefinedCategories();
      return false;
    } else {
      return true;
    }
  }

  static Future<void> removeCategory(String categoryName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? categoriesList = prefs.getStringList(_incomeCategoriesKey);
    if (categoriesList == null || categoriesList.isEmpty) {
      return;
    }
    int categoryIndex = categoriesList.indexWhere((categoryJson) {
      Map<String, dynamic> categoryData = json.decode(categoryJson);
      return categoryData['categoryName'] == categoryName;
    });
    if (categoryIndex != -1) {
      categoriesList.removeAt(categoryIndex);
      await prefs.setStringList(_incomeCategoriesKey, categoriesList);
    }
  }

  static const String _totalIncomeKey = 'total_income_key';

  static Future<double> loadTotalIncome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_totalIncomeKey) ?? 0.0;
  }

  static Future<void> saveTotalIncome(double totalIncome) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_totalIncomeKey, totalIncome);
  }

  static Future<void> clearCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_incomeCategoriesKey);
  }
}
