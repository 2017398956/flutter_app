/// name : ""
library;

class Student {
  Student({
    String? name,
  }) {
    _name = name;
  }

  Student.fromJson(dynamic json) {
    _name = json['name'];
  }

  String? _name;

  Student copyWith({
    String? name,
  }) =>
      Student(
        name: name ?? _name,
      );

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }
}
