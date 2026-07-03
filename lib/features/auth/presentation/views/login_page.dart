import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/utils/toast.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_state.dart';
import 'package:education_project_example/features/auth/presentation/manager/register/register_cubit.dart';
import 'widgets/auth_header_widget.dart';
import 'widgets/auth_switch_prompt_widget.dart';
import 'widgets/login_form_widget.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (prev, curr) => curr.status == LoginStatus.success,
      listener: (context, state) {
        AppToast.show('Welcome ${state.user?.name}!', AppToastType.success);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AuthHeaderWidget(
                  title: 'Welcome back',
                  subtitle: 'Login to continue to your account',
                ),
                SizedBox(height: 24.h),
                const LoginFormWidget(),
                SizedBox(height: 16.h),
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
      ),
    );
  }
}
