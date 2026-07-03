import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:education_project_example/features/auth/presentation/views/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                SubmitButton(
                  label: 'Sign out',
                  onPressed: () => _signOut(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
