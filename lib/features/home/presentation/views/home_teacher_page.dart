import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/features/home/presentation/views/widgets/sign_out_button.dart';

class HomeTeacherPage extends StatelessWidget {
  const HomeTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Teacher Home',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24.h),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}
