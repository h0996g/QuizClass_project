import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/features/lessons/data/models/lesson_model.dart';
import 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(const LessonsState());

  Future<void> fetchLessons() async {
    emit(state.copyWith(status: LessonsStatus.loading));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .where('teacherId', isEqualTo: uid)
          .get();

      final lessons = querySnapshot.docs
          .map((doc) => LessonModel.fromMap(doc.id, doc.data()))
          .toList();

      emit(state.copyWith(status: LessonsStatus.success, lessons: lessons));
    } catch (e) {
      emit(
        state.copyWith(status: LessonsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> fetchAllLessons() async {
    emit(state.copyWith(status: LessonsStatus.loading));

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('lessons').get();

      final lessons = querySnapshot.docs
          .map((doc) => LessonModel.fromMap(doc.id, doc.data()))
          .toList();

      emit(state.copyWith(status: LessonsStatus.success, lessons: lessons));
    } catch (e) {
      emit(
        state.copyWith(status: LessonsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> addLesson({
    required String title,
    required String description,
  }) async {
    emit(state.copyWith(status: LessonsStatus.loading));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final lesson = LessonModel(
        id: '',
        title: title,
        description: description,
        teacherId: uid,
      );
      await FirebaseFirestore.instance.collection('lessons').add(lesson.toMap());
      await fetchLessons();
    } catch (e) {
      emit(
        state.copyWith(status: LessonsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> updateLesson({
    required String id,
    required String title,
    required String description,
  }) async {
    emit(state.copyWith(status: LessonsStatus.loading));

    try {
      await FirebaseFirestore.instance.collection('lessons').doc(id).update({
        'title': title,
        'description': description,
      });

      final updatedLessons = state.lessons
          .map(
            (lesson) => lesson.id == id
                ? lesson.copyWith(title: title, description: description)
                : lesson,
          )
          .toList();
      emit(state.copyWith(status: LessonsStatus.success, lessons: updatedLessons));
    } catch (e) {
      emit(
        state.copyWith(status: LessonsStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> deleteLesson(String id) async {
    emit(state.copyWith(status: LessonsStatus.loading));

    try {
      await FirebaseFirestore.instance.collection('lessons').doc(id).delete();

      final updatedLessons =
          state.lessons.where((lesson) => lesson.id != id).toList();
      emit(state.copyWith(status: LessonsStatus.success, lessons: updatedLessons));
    } catch (e) {
      emit(
        state.copyWith(status: LessonsStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
