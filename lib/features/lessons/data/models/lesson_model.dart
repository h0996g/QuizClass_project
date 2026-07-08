import 'package:cloud_firestore/cloud_firestore.dart';

class LessonModel {
  const LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String teacherId;
  final Timestamp? createdAt;

  factory LessonModel.fromMap(String id, Map<String, dynamic> map) {
    return LessonModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      teacherId: map['teacherId'] ?? '',
      createdAt: map['createdAt'],
    );
  }

  LessonModel copyWith({
    String? id,
    String? title,
    String? description,
    String? teacherId,
    Timestamp? createdAt,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      teacherId: teacherId ?? this.teacherId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'teacherId': teacherId,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  @override
  String toString() =>
      'LessonModel(id: $id, title: $title, description: $description, teacherId: $teacherId)';
}
