import 'package:education_project_example/features/auth/data/models/user_model.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.errorMessage,
  });

  final LoginStatus status;
  final UserModel? user;
  final String? errorMessage;

  LoginState copyWith({
    LoginStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'LoginState(status: $status, user: $user, errorMessage: $errorMessage)';
  }
}
