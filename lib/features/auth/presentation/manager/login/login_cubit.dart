import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/constants/app_constants.dart';
import 'package:education_project_example/core/utils/validators.dart';
import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with RoleHandler {
  LoginCubit() : super(const LoginState());

  @override
  void onRoleChanged(UserRole role) =>
      emit(state.copyWith(role: role, status: LoginStatus.initial));

  Future<void> submit({required String email, required String password}) async {
    final emailError = Validators.email(email);
    final passwordError = Validators.password(password);
    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: emailError ?? passwordError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final user = await _mockLogin(email: email, role: state.role);
      emit(
        state.copyWith(
          status: LoginStatus.success,
          user: user,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<UserModel> _mockLogin({
    required String email,
    required UserRole role,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: AppConstants.mockNetworkDelayMs),
    );

    if (email.toLowerCase() == 'error@example.com') {
      throw Exception('Invalid email or password.');
    }

    return UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      name: email.split('@').first,
      email: email,
      role: role,
    );
  }
}
