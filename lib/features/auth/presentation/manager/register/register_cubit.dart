import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onRoleChanged(UserRole role) => emit(state.copyWith(role: role));

  Future<void> submit({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final uid = credential.user!.uid;
      final user = UserModel(
        id: uid,
        name: name,
        email: email,
        role: state.role,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(user.toMap());
      emit(state.copyWith(status: RegisterStatus.success, user: user));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: RegisterStatus.error,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
