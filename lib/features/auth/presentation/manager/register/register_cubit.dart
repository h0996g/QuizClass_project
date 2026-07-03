import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/constants/app_constants.dart';
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
    emit(state.copyWith(status: RegisterStatus.loading));

    await Future.delayed(
      const Duration(milliseconds: AppConstants.mockNetworkDelayMs),
    );

    emit(
      state.copyWith(
        status: RegisterStatus.success,
        user: UserModel(
          id: 'u_${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          email: email,
          role: state.role,
        ),
      ),
    );
  }
}
