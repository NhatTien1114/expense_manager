import 'package:expense_manager/model/Category.dart';
import 'package:expense_manager/model/Tag.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:expense_manager/model/Expense.dart';
import 'dart:convert';

class ExpenseProvider with ChangeNotifier{
  final LocalStorage storage;
  List<Expense> _expense = [];

  List<Expense> get expense => _expense;

  final List<Category> _categories = [
    Category(id: '1', name: 'Food', isDefault: true),
    Category(id: '2', name: 'Transport', isDefault: true),
    Category(id: '3', name: 'Entertainment', isDefault: true),
    Category(id: '4', name: 'Office', isDefault: true),
    Category(id: '5', name: 'Gym', isDefault: true),
  ];

  final List<Tag> _tags = [
    Tag(id: '1', name: 'Breakfast'),
    Tag(id: '2', name: 'Lunch'),
    Tag(id: '3', name: 'Dinner'),
    Tag(id: '4', name: 'Treat'),
    Tag(id: '5', name: 'Cafe'),
    Tag(id: '6', name: 'Restaurant'),
    Tag(id: '7', name: 'Train'),
    Tag(id: '8', name: 'Vacation'),
    Tag(id: '9', name: 'Birthday'),
    Tag(id: '10', name: 'Diet'),
    Tag(id: '11', name: 'MovieNight'),
    Tag(id: '12', name: 'Tech'),
    Tag(id: '13', name: 'CarStuff'),
    Tag(id: '14', name: 'SelfCare'),
    Tag(id: '15', name: 'Streaming'),
  ];

  List<Expense> get expenses => _expense;
  List<Category> get categories => _categories;
  List<Tag> get tags => _tags;

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

  void removeExpense(String id) {
    _expense.removeWhere((e) => e.id == id);
    _saveExpenseToStorage();
    notifyListeners();
  }

  void addCategory(Category category) {
    if (!_categories.any((cat) => cat.name == category.name)) {
      _categories.add(category);
      notifyListeners();
    }
  }

  void deleteCategory(String id) {
    _categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }

  void addTag(Tag tag) {
    if (!_tags.any((t) => t.name == tag.name)) {
      _tags.add(tag);
      notifyListeners();
    }
  }
  
  void deleteTag(String id) {
    _tags.removeWhere((tag) => tag.id == id);
    notifyListeners();
  }
}