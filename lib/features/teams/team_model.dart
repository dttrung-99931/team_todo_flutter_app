import 'dart:convert';

class TeamModel {
  final String name;
  final String description;

  TeamModel(this.name, this.description);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      map['name'],
      map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source));
}
