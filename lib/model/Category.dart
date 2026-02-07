class Category {
  final String _id;
  final String _name;

  String get id => _id;
  String get name => _name;

  Category({
    required String id,
    required String name,
  }) :  _id = id,
        _name = name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}