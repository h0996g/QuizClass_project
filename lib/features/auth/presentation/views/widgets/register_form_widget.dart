import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/theme/app_text_styles.dart';
import 'package:education_project_example/core/utils/validators.dart';
import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/core/widgets/text_input.dart';
import 'package:education_project_example/core/widgets/text_input_password.dart';
import 'package:education_project_example/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:education_project_example/features/auth/presentation/manager/register/register_state.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().submit(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Full name',
                style: AppTextStyles.fieldLabel,
              ),
              SizedBox(height: 6.h),
              TextInput(
                controller: _nameController,
                hint: 'Jane Doe',
                textInputAction: TextInputAction.next,
                validator: (v) => Validators.required(v, fieldName: 'Name'),
              ),
              SizedBox(height: 16.h),
              Text(
                'Email',
                style: AppTextStyles.fieldLabel,
              ),
              SizedBox(height: 6.h),
              TextInput(
                controller: _emailController,
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
                validator: Validators.password,
              ),
              SizedBox(height: 16.h),
              Text(
                'Confirm password',
                style: AppTextStyles.fieldLabel,
              ),
              SizedBox(height: 6.h),
              TextInputPassword(
                controller: _confirmController,
                hint: '••••••••',
                validator: (v) =>
                    Validators.confirmPassword(v, _passwordController.text),
              ),
              if (state.isError && state.errorMessage != null) ...[
                SizedBox(height: 12.h),
                Text(
                  state.errorMessage!,
                  style: AppTextStyles.errorText,
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 24.h),
              SubmitButton(
                label: 'Create account',
                onPressed: _submit,
                isLoading: state.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}
