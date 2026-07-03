import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:education_project_example/core/theme/app_text_styles.dart';
import 'package:education_project_example/core/utils/validators.dart';
import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/core/widgets/text_input.dart';
import 'package:education_project_example/core/widgets/text_input_password.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_state.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Email',
                style: AppTextStyles.fieldLabel,
              ),
              SizedBox(height: 6.h),
              TextInput(
                controller: _emailController,
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              SizedBox(height: 16.h),
              Text(
                'Password',
                style: AppTextStyles.fieldLabel,
              ),
              SizedBox(height: 6.h),
              TextInputPassword(
                controller: _passwordController,
                hint: '••••••••',
                validator: Validators.password,
              ),
              SizedBox(height: 24.h),
              SubmitButton(
                label: 'Login',
                onPressed: _submit,
                isLoading: state.status == LoginStatus.loading,
              ),
            ],
          ),
        );
      },
    );
  }
}
