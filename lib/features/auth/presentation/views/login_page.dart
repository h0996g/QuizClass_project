import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/utils/toast.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_state.dart';
import 'package:education_project_example/features/auth/presentation/manager/register/register_cubit.dart';
import 'widgets/auth_header_widget.dart';
import 'widgets/auth_role_selector_widget.dart';
import 'widgets/auth_switch_prompt_widget.dart';
import 'widgets/login_form_widget.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (prev, curr) => curr.isSuccess,
      listener: (context, state) {
        AppToast.show('Welcome ${state.user?.name}!', AppToastType.success);
      },
      buildWhen: (prev, curr) => prev.role != curr.role,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthHeaderWidget(
                    title: 'Welcome back',
                    subtitle: 'Login to continue to your account',
                  ),
                  const SizedBox(height: 24),
                  AuthRoleSelectorWidget(
                    role: state.role,
                    onChanged: context.read<LoginCubit>().onRoleChanged,
                  ),
                  const SizedBox(height: 24),
                  const LoginFormWidget(),
                  const SizedBox(height: 16),
                  AuthSwitchPromptWidget(
                    promptText: "Don't have an account? ",
                    actionText: 'Register',
                    onActionTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => RegisterCubit(),
                            child: const RegisterPage(),
                          ),
                        ),
                      );
                    },
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
