import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/features/lessons/data/models/lesson_model.dart';
import 'package:education_project_example/features/lessons/presentation/manager/lessons/lessons_cubit.dart';
import 'package:education_project_example/features/lessons/presentation/manager/lessons/lessons_state.dart';
import 'package:education_project_example/features/lessons/presentation/views/add_lesson_page.dart';
import 'package:education_project_example/features/lessons/presentation/views/edit_lesson_page.dart';
import 'package:education_project_example/features/lessons/presentation/widgets/lesson_card.dart';
import 'package:education_project_example/features/lessons/presentation/widgets/lessons_empty_view.dart';
import 'package:education_project_example/features/lessons/presentation/widgets/lessons_error_view.dart';
import 'package:education_project_example/features/lessons/presentation/widgets/lessons_shimmer_loading.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  void _openAddForm(BuildContext context) {
    final cubit = context.read<LessonsCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const AddLessonPage()),
      ),
    );
  }

  void _openEditForm(BuildContext context, LessonModel lesson) {
    final cubit = context.read<LessonsCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: EditLessonPage(lesson: lesson),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LessonsCubit, LessonsState>(
        builder: (context, state) {
          if (state.status == LessonsStatus.loading) {
            return const LessonsShimmerLoading();
          }

          if (state.status == LessonsStatus.error) {
            return LessonsErrorView(
              message: state.errorMessage,
              onRetry: () => context.read<LessonsCubit>().fetchLessons(),
            );
          }

          if (state.lessons.isEmpty) {
            return const LessonsEmptyView();
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            itemCount: state.lessons.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final lesson = state.lessons[index];
              return LessonCard(
                lesson: lesson,
                onEdit: () => _openEditForm(context, lesson),
                onDelete: () =>
                    context.read<LessonsCubit>().deleteLesson(lesson.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
