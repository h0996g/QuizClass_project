import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/constants/cache_keys.dart';
import 'package:education_project_example/core/helper/cache_helper.dart';
import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onRoleChanged(UserRole role) => emit(state.copyWith(role: role));

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        role: state.role,
      );
      await _saveUserProfile(user);
    } catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _saveUserProfile(UserModel user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.toMap());

    await CacheHelper.putCache(key: CacheKeys.userRole, value: user.role?.name);

    emit(state.copyWith(status: RegisterStatus.success, user: user));
  }
}
