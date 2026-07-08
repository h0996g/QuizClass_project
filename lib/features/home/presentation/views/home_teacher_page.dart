import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/features/home/presentation/views/widgets/sign_out_button.dart';

class HomeTeacherPage extends StatelessWidget {
  const HomeTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, Teacher 👋',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              _StatCard(icon: Icons.menu_book, value: '12', label: 'Lessons'),
              SizedBox(width: 12.w),
              _StatCard(icon: Icons.people, value: '48', label: 'Students'),
              SizedBox(width: 12.w),
              _StatCard(
                icon: Icons.pending_actions,
                value: '5',
                label: 'Pending',
              ),
            ],
          ),
          SizedBox(height: 32.h),
          const Center(child: SignOutButton()),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24.sp, color: Theme.of(context).primaryColor),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
