import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterState {
  final UserRole role;
  final RegisterStatus status;
  final UserModel? user;
  final String? errorMessage;

  const RegisterState({
    this.role = UserRole.student,
    this.status = RegisterStatus.initial,
    this.user,
    this.errorMessage,
  });

  bool get isLoading => status == RegisterStatus.loading;
  bool get isSuccess => status == RegisterStatus.success;
  bool get isError => status == RegisterStatus.error;

  RegisterState copyWith({
    UserRole? role,
    RegisterStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return RegisterState(
      role: role ?? this.role,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'RegisterState(role: $role, status: $status, user: $user, errorMessage: $errorMessage)';
  }
}
