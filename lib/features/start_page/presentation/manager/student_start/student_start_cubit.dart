import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'student_start_state.dart';

class StudentStartCubit extends Cubit<StudentStartState> {
  StudentStartCubit() : super(const StudentStartState()) {
    fetchProfile();
  }

  void changeIndex(int index) => emit(state.copyWith(currentIndex: index));

  Future<void> fetchProfile() async {
    emit(state.copyWith(profileStatus: ProfileFetchStatus.loading));
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (!doc.exists) {
        emit(
          state.copyWith(
            profileStatus: ProfileFetchStatus.error,
            profileErrorMessage: 'Profile not found',
          ),
        );
        return;
      }
      final user = UserModel.fromMap(uid, doc.data()!);
      emit(state.copyWith(profileStatus: ProfileFetchStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileFetchStatus.error,
          profileErrorMessage: e.toString(),
        ),
      );
    }
  }
}
