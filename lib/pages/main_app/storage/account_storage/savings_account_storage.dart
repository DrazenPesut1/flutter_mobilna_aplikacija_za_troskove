import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SavingsAccountStorage {
  static const String _savingsAccountsKey = 'savings_accounts_list';

  static Future<void> saveAccount(Map<String, dynamic> accountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_savingsAccountsKey);
    accountsList ??= [];
    String accountJson = json.encode(accountData);
    accountsList.add(accountJson);
    await prefs.setStringList(_savingsAccountsKey, accountsList);
  }

  static Future<void> removeAccount(String accountName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_savingsAccountsKey);
    if (accountsList == null) {
      return;
    }
    accountsList.removeWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == accountName;
    });
    await prefs.setStringList(_savingsAccountsKey, accountsList);
  }

  static Future<List<Map<String, dynamic>>> loadAccounts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_savingsAccountsKey);
    if (accountsList == null) {
      return [];
    }
    return accountsList.map((accountJson) {
      return json.decode(accountJson) as Map<String, dynamic>;
    }).toList();
  }

  static Future<void> updateBalance(Map<String, dynamic> updatedAccountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_savingsAccountsKey);
    if (accountsList == null) {
      return;
    }
    int accountIndex = accountsList.indexWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == updatedAccountData['accountName'];
    });
    if (accountIndex != -1) {
      accountsList[accountIndex] = json.encode(updatedAccountData);
      await prefs.setStringList(_savingsAccountsKey, accountsList);
    }
  }

  static Future<void> clearAccounts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
