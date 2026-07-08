import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/utils/validators.dart';
import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/core/widgets/text_input.dart';
import 'package:education_project_example/features/lessons/data/models/lesson_model.dart';
import 'package:education_project_example/features/lessons/presentation/manager/lessons/lessons_cubit.dart';

class EditLessonPage extends StatefulWidget {
  const EditLessonPage({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  State<EditLessonPage> createState() => _EditLessonPageState();
}

class _EditLessonPageState extends State<EditLessonPage> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(
    text: widget.lesson.title,
  );
  late final _descriptionController = TextEditingController(
    text: widget.lesson.description,
  );

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LessonsCubit>().updateLesson(
      id: widget.lesson.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Lesson')),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextInput(
                controller: _titleController,
                label: 'Title',
                hint: 'Lesson title',
                validator: (value) =>
                    Validators.required(value, fieldName: 'Title'),
              ),
              SizedBox(height: 12.h),
              TextInput(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Lesson description',
                textInputAction: TextInputAction.done,
                validator: (value) =>
                    Validators.required(value, fieldName: 'Description'),
              ),
              SizedBox(height: 20.h),
              SubmitButton(label: 'Save', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
