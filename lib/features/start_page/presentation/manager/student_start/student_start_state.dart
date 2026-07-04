import 'package:education_project_example/features/auth/data/models/user_model.dart';

enum ProfileFetchStatus { initial, loading, success, error }

class StudentStartState {
  const StudentStartState({
    this.currentIndex = 0,
    this.profileStatus = ProfileFetchStatus.initial,
    this.user,
    this.profileErrorMessage,
  });

  final int currentIndex;
  final ProfileFetchStatus profileStatus;
  final UserModel? user;
  final String? profileErrorMessage;

  StudentStartState copyWith({
    int? currentIndex,
    ProfileFetchStatus? profileStatus,
    UserModel? user,
    String? profileErrorMessage,
  }) {
    return StudentStartState(
      currentIndex: currentIndex ?? this.currentIndex,
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      profileErrorMessage: profileErrorMessage ?? this.profileErrorMessage,
    );
  }

  @override
  String toString() {
    return 'StudentStartState(currentIndex: $currentIndex, profileStatus: $profileStatus, user: $user, profileErrorMessage: $profileErrorMessage)';
  }
}
