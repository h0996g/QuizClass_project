import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/utils/toast.dart';
import 'package:education_project_example/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:education_project_example/features/auth/presentation/manager/register/register_state.dart';
import 'package:education_project_example/features/home/presentation/views/home_page.dart';
import 'widgets/auth_header_widget.dart';
import 'widgets/auth_role_selector_widget.dart';
import 'widgets/auth_switch_prompt_widget.dart';
import 'widgets/register_form_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (prev, curr) => curr.isSuccess || curr.isError,
      listener: (context, state) {
        if (state.isError) {
          AppToast.show(
            state.errorMessage ?? 'Registration failed',
            AppToastType.error,
          );
          return;
        }
        AppToast.show(
          'Account created for ${state.user?.email}!',
          AppToastType.success,
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      },
      buildWhen: (prev, curr) => prev.role != curr.role,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthHeaderWidget(
                    title: 'Create account',
                    subtitle: 'Join us as a student or a teacher',
                  ),
                  SizedBox(height: 24.h),
                  AuthRoleSelectorWidget(
                    role: state.role,
                    onChanged: context.read<RegisterCubit>().onRoleChanged,
                  ),
                  SizedBox(height: 24.h),
                  const RegisterFormWidget(),
                  SizedBox(height: 16.h),
                  AuthSwitchPromptWidget(
                    promptText: 'Already have an account? ',
                    actionText: 'Login',
                    onActionTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
