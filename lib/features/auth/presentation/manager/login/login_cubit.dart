import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> submit({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (!doc.exists) {
        emit(
          state.copyWith(
            status: LoginStatus.error,
            errorMessage: 'No profile found for this account.',
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          status: LoginStatus.success,
          user: UserModel.fromMap(uid, doc.data()!),
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(status: LoginStatus.error, errorMessage: e.toString()),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
