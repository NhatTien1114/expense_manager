class Category {
  final String _id;
  final String _name;
  final bool _isDefault;

  String get id => _id;
  String get name => _name;
  bool get isDefault => _isDefault;

  Category({
    required String id,
    required String name,
    bool isDefault = false,
  }) :  _id = id,
        _name = name,
        _isDefault = isDefault;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      isDefault: json['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isDefault': isDefault,
    };
  }
}