import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/constants/app_constants.dart';
import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> submit({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));

    await Future.delayed(
      const Duration(milliseconds: AppConstants.mockNetworkDelayMs),
    );

    emit(
      state.copyWith(
        status: LoginStatus.success,
        user: UserModel(
          id: 'u_${DateTime.now().millisecondsSinceEpoch}',
          name: email.split('@').first,
          email: email,
        ),
      ),
    );
  }
}
