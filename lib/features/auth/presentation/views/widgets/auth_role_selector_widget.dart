import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/theme/app_colors.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';

class AuthRoleSelectorWidget extends StatefulWidget {
  const AuthRoleSelectorWidget({
    super.key,
    required this.role,
    required this.onChanged,
  });

  final UserRole role;
  final ValueChanged<UserRole> onChanged;

  @override
  State<AuthRoleSelectorWidget> createState() => _AuthRoleSelectorWidgetState();
}

class _AuthRoleSelectorWidgetState extends State<AuthRoleSelectorWidget> {
  late UserRole _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.role;
  }

  @override
  void didUpdateWidget(AuthRoleSelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.role != widget.role) {
      _selected = widget.role;
    }
  }

  void _onTap(UserRole role) {
    if (_selected == role) return;
    setState(() => _selected = role);
    widget.onChanged(role);
  }

  @override
  Widget build(BuildContext context) {
    final roles = UserRole.values;
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: roles.map((r) {
          final selected = r == _selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => _onTap(r),
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
                      r.icon,
                      size: 18.sp,
                      color: selected
                          ? Colors.white
                          : Colors.grey.shade700,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      r.label,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.grey.shade700,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
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
