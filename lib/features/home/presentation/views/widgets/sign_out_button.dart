import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/helper/cache_helper.dart';
import 'package:education_project_example/core/widgets/submit_button.dart';
import 'package:education_project_example/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:education_project_example/features/auth/presentation/views/login_page.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  bool _isLoading = false;

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeAll();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider(create: (_) => LoginCubit(), child: const LoginPage()),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      label: 'Sign out',
      isLoading: _isLoading,
      onPressed: _signOut,
    );
  }
}
