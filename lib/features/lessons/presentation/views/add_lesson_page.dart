import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/utils/validators.dart';
import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/core/widgets/text_input.dart';
import 'package:education_project_example/features/lessons/presentation/manager/lessons/lessons_cubit.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({super.key});

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<LessonsCubit>().addLesson(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Lesson')),
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
