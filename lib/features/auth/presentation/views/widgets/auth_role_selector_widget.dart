import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/theme/app_colors.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';

class AuthRoleSelectorWidget extends StatelessWidget {
  const AuthRoleSelectorWidget({
    super.key,
    required this.role,
    required this.onChanged,
  });

  final UserRole role;
  final ValueChanged<UserRole> onChanged;

  String _labelFor(UserRole role) {
    switch (role) {
      case UserRole.student:
        return 'Student';
      case UserRole.teacher:
        return 'Teacher';
    }
  }

  IconData _iconFor(UserRole role) {
    switch (role) {
      case UserRole.student:
        return Icons.school_outlined;
      case UserRole.teacher:
        return Icons.co_present_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: UserRole.values.map((r) {
          final selected = r == role;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _iconFor(r),
                      size: 18.sp,
                      color: selected ? Colors.white : Colors.grey.shade700,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _labelFor(r),
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.grey.shade700,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
