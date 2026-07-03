import 'package:flutter/material.dart';

enum UserRole { student, teacher }

mixin RoleHandler {
  void onRoleChanged(UserRole role);
}

extension UserRoleX on UserRole {
  String get label {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.teacher:
        return 'Teacher';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.student:
        return Icons.school_outlined;
      case UserRole.teacher:
        return Icons.co_present_outlined;
    }
  }
}
