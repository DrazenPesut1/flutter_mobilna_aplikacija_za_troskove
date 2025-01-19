import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegularAccountStorage {
  static const String _regularAccountsKey = 'regular_accounts_list';
  static const String _totalBalanceKey = 'total_balance';

  static Future<void> saveAccount(Map<String, dynamic> accountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_regularAccountsKey);
    accountsList ??= [];
    String accountJson = json.encode(accountData);
    accountsList.add(accountJson);
    await prefs.setStringList(_regularAccountsKey, accountsList);
  }

  static Future<List<Map<String, dynamic>>> loadAccounts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_regularAccountsKey);
    if (accountsList == null) {
      return [];
    }
    return accountsList.map((accountJson) {
      return json.decode(accountJson) as Map<String, dynamic>;
    }).toList();
  }

  static Future<List<Map<String, dynamic>>> loadAccountsExcept(String excludedAccountName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_regularAccountsKey);
    if (accountsList == null) {
      return [];
    }
    return accountsList.where((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] != excludedAccountName;
    }).map((accountJson) {
      return json.decode(accountJson) as Map<String, dynamic>;
    }).toList();
  }

  static Future<void> updateBalance(Map<String, dynamic> updatedAccountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_regularAccountsKey);
    if (accountsList == null) {
      return;
    }
    int accountIndex = accountsList.indexWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == updatedAccountData['accountName'];
    });
    if (accountIndex != -1) {
      accountsList[accountIndex] = json.encode(updatedAccountData);
      await prefs.setStringList(_regularAccountsKey, accountsList);
    }
  }

  static Future<double> loadTotalBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_totalBalanceKey) ?? 0.0;
  }

  static Future<void> saveTotalBalance(double totalBalance) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_totalBalanceKey, totalBalance);
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> editAccount(Map<String, dynamic> updatedAccountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_regularAccountsKey);
    if (accountsList == null) {
      return;
    }
    int accountIndex = accountsList.indexWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == updatedAccountData['oldAccountName'];
    });
    if (accountIndex != -1) {
      accountsList[accountIndex] = json.encode(updatedAccountData);
      await prefs.setStringList(_regularAccountsKey, accountsList);
    }
  }

  static Future<void> removeAccount(String accountName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_regularAccountsKey);
    if (accountsList == null) {
      return;
    }
    int accountIndex = accountsList.indexWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == accountName;
    });
    if (accountIndex != -1) {
      accountsList.removeAt(accountIndex);
      await prefs.setStringList(_regularAccountsKey, accountsList);
    }
  }
}
