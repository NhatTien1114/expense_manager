class Tag {
  final String _id;
  final String _name;

  String get id => _id;
  String get name => _name;

  Tag({
    required String id,
    required String name,
  }) :  _id = id,
        _name = name;

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
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