// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int roll;
  StudentModel({
    required this.name,
    required this.roll,
  });

  StudentModel copyWith({
    String? name,
    int? roll,
  }) {
    return StudentModel(
      name: name ?? this.name,
      roll: roll ?? this.roll,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'roll': roll,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      name: map['name'] as String,
      roll: map['roll'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StudentModel(name: $name, roll: $roll)';

  @override
  bool operator ==(covariant StudentModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.roll == roll;
  }

  @override
  int get hashCode => name.hashCode ^ roll.hashCode;
}
