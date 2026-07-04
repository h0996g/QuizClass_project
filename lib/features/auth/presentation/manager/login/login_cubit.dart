import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/core/constants/cache_keys.dart';
import 'package:education_project_example/core/helper/cache_helper.dart';
import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _fetchUserProfile(credential.user!.uid);
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _fetchUserProfile(String uid) async {
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
    final user = UserModel.fromMap(uid, doc.data()!);

    await CacheHelper.putCache(key: CacheKeys.userRole, value: user.role?.name);

    emit(state.copyWith(status: LoginStatus.success, user: user));
  }
}
