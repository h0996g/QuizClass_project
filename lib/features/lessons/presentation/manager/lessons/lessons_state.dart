import 'package:education_project_example/features/lessons/data/models/lesson_model.dart';

enum LessonsStatus { initial, loading, success, error }

class LessonsState {
  const LessonsState({
    this.status = LessonsStatus.initial,
    this.lessons = const [],
    this.errorMessage,
  });

  final LessonsStatus status;
  final List<LessonModel> lessons;
  final String? errorMessage;

  LessonsState copyWith({
    LessonsStatus? status,
    List<LessonModel>? lessons,
    String? errorMessage,
  }) {
    return LessonsState(
      status: status ?? this.status,
      lessons: lessons ?? this.lessons,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'LessonsState(status: $status, lessons: $lessons, errorMessage: $errorMessage)';
  }
}
