import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/features/home/presentation/views/home_student_page.dart';
import 'package:education_project_example/features/profile/presentation/views/profile_student_page.dart';
import 'package:education_project_example/features/start_page/presentation/manager/student_start/student_start_cubit.dart';
import 'package:education_project_example/features/start_page/presentation/manager/student_start/student_start_state.dart';

class StudentStartPage extends StatelessWidget {
  const StudentStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentStartCubit, StudentStartState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              const HomeStudentPage(),
              ProfileStudentPage(state: state),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) =>
                context.read<StudentStartCubit>().changeIndex(index),
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
