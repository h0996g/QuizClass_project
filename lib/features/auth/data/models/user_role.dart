enum UserRole { student, teacher }

UserRole? toUserRole(String? value) {
  switch (value) {
    case 'student':
      return UserRole.student;
    case 'teacher':
      return UserRole.teacher;
    default:
      return null;
  }
}
