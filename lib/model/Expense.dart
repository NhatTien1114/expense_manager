class Expense {
  final String _id;
  final double _amount;
  final String _categoryId;
  final String _payee;
  final String _note;
  final DateTime _date;
  final String _tag;

  String get id => _id;
  double get amount => _amount;
  String get categoryId => _categoryId;
  String get payee => _payee;
  String get note => _note;
  DateTime get date => _date;
  String get tag => _tag;

  Expense({
    required String id,
    required double amount,
    required String categoryId,
    required String payee,
    required String note,
    required DateTime date,
    required String tag
  }) : _id = id,
        _amount = amount,
        _categoryId = categoryId,
        _payee = payee,
        _note = note,
        _date = date,
        _tag = tag;


  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      amount: json['amount'],
      categoryId: json['categoryId'],
      payee: json['payee'],
      note: json['note'],
      date: DateTime.parse(json['date']),
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'payee': payee,
      'note': note,
      'date': date.toIso8601String(),
      'tag': tag,
    };
  }
}