import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:expense_manager/model/Expense.dart';
import 'dart:convert';

class ExpenseProvider with ChangeNotifier{
  final LocalStorage storage;
  List<Expense> _expense = [];

  List<Expense> get expense => _expense;

  ExpenseProvider(this.storage) {
    _loadExpesesFromStorage();
  }

  void _loadExpesesFromStorage() async{
    var storedExpenses = storage.getItem('expenses');
    if (storedExpenses != null) {
      _expense = List<Expense>.from(
          (storedExpenses as List).map((item) => Expense.fromJson(item))
      );
      notifyListeners();
    }
  }

  void _saveExpenseToStorage() {
    storage.setItem('expenses', jsonEncode(_expense.map((e) => e.toJson()).toList()));
  }

  void addExpense(Expense expense) {
    _expense.add(expense);
    _saveExpenseToStorage();
    notifyListeners();
  }

  void addOrUpdateExpense(Expense expense) {
    int index = _expense.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expense[index] = expense;
    } else {
      _expense.add(expense);
    }
    _saveExpenseToStorage();
    notifyListeners();
  }

  void removeExpense(int id) {
    _expense.removeWhere((e) => e.id == id);
    _saveExpenseToStorage();
    notifyListeners();
  }
}