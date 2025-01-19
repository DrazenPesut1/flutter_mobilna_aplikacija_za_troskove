import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebtsAccountStorage {
  static const String _debtsAccountsKey = 'debts_accounts_list';

  static Future<void> saveAccount(Map<String, dynamic> accountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(accountData['selectedType'].toString());

    List<String>? accountsList = prefs.getStringList(_debtsAccountsKey);
    accountsList ??= [];

    String accountJson = json.encode(accountData);
    accountsList.add(accountJson);

    await prefs.setStringList(_debtsAccountsKey, accountsList);
  }

  static Future<void> updateBalance(Map<String, dynamic> updatedAccountData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_debtsAccountsKey);

    if (accountsList == null) {
      return;
    }

    int accountIndex = accountsList.indexWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == updatedAccountData['accountName'];
    });

    if (accountIndex != -1) {
      accountsList[accountIndex] = json.encode(updatedAccountData);
      await prefs.setStringList(_debtsAccountsKey, accountsList);
      debugPrint("Updated account balance successfully: ${updatedAccountData['accountName']}");
    } else {
      debugPrint("Account not found: ${updatedAccountData['accountName']}");
    }
  }

  static Future<void> removeAccount(String accountName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_debtsAccountsKey);

    if (accountsList == null) {
      return;
    }

    accountsList.removeWhere((accountJson) {
      Map<String, dynamic> accountData = json.decode(accountJson);
      return accountData['accountName'] == accountName;
    });

    await prefs.setStringList(_debtsAccountsKey, accountsList);
    debugPrint("Removed account: $accountName");
  }

  static Future<List<Map<String, dynamic>>> loadAccounts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? accountsList = prefs.getStringList(_debtsAccountsKey);

    if (accountsList == null) {
      return [];
    }

    return accountsList.map((accountJson) {
      Map<String, dynamic> account = json.decode(accountJson) as Map<String, dynamic>;
      debugPrint(account['selectedType'].toString());
      return account;
    }).toList();
  }

  static Future<void> clearAccounts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
