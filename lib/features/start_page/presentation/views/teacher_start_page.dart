import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/features/home/presentation/views/home_teacher_page.dart';
import 'package:education_project_example/features/profile/presentation/views/profile_teacher_page.dart';
import 'package:education_project_example/features/start_page/presentation/manager/teacher_start/teacher_start_cubit.dart';
import 'package:education_project_example/features/start_page/presentation/manager/teacher_start/teacher_start_state.dart';

class TeacherStartPage extends StatelessWidget {
  const TeacherStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherStartCubit, TeacherStartState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              const HomeTeacherPage(),
              ProfileTeacherPage(state: state),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<TeacherStartCubit>().changeIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
