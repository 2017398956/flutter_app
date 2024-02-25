/// name : "LiLei"

class Person {
  Person({
    String? name,
  }) {
    _name = name;
  }

  Person.fromJson(dynamic json) {
    _name = json['name'];
  }

  String? _name;

  Person copyWith({
    String? name,
  }) =>
      Person(
        name: name ?? _name,
      );

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }
}
