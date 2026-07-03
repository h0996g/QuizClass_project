enum UserRole { student, teacher }

extension UserRoleParse on String? {
  UserRole? toUserRole() {
    switch (this) {
      case 'student':
        return UserRole.student;
      case 'teacher':
        return UserRole.teacher;
      default:
        return null;
    }
  }
}
