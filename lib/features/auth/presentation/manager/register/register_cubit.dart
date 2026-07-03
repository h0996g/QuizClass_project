import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/constants/app_constants.dart';
import 'package:education_project_example/core/utils/validators.dart';
import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> with RoleHandler {
  RegisterCubit() : super(const RegisterState());

  @override
  void onRoleChanged(UserRole role) =>
      emit(state.copyWith(role: role, status: RegisterStatus.initial));

  Future<void> submit({
    required String name,
    required String email,
    required String password,
  }) async {
    final nameError = Validators.required(name, fieldName: 'Name');
    final emailError = Validators.email(email);
    final passwordError = Validators.password(password);

    final firstError = [
      nameError,
      emailError,
      passwordError,
    ].firstWhere((e) => e != null, orElse: () => null);

    if (firstError != null) {
      emit(
        state.copyWith(status: RegisterStatus.error, errorMessage: firstError),
      );
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      final user = await _mockRegister(
        name: name,
        email: email,
        role: state.role,
      );
      emit(
        state.copyWith(
          status: RegisterStatus.success,
          user: user,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<UserModel> _mockRegister({
    required String name,
    required String email,
    required UserRole role,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: AppConstants.mockNetworkDelayMs),
    );

    if (email.toLowerCase() == 'taken@example.com') {
      throw Exception('This email is already registered.');
    }

    return UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      role: role,
    );
  }
}
