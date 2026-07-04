import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:education_project_example/features/auth/presentation/views/login_page.dart';
import 'package:education_project_example/features/profile/presentation/views/profile_student_page.dart';
import 'package:education_project_example/features/start_page/presentation/manager/student_start/student_start_cubit.dart';
import 'package:education_project_example/features/start_page/presentation/manager/student_start/student_start_state.dart';

class StudentStartPage extends StatelessWidget {
  const StudentStartPage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider(create: (_) => LoginCubit(), child: const LoginPage()),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentStartCubit, StudentStartState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              _HomeTab(onSignOut: () => _signOut(context)),
              ProfileStudentPage(state: state),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<StudentStartCubit>().changeIndex(index),
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

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.onSignOut});

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Student Home',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24.h),
            SubmitButton(label: 'Sign out', onPressed: onSignOut),
          ],
        ),
      ),
    );
  }
}
