import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';

/// All possible states the register flow can be in.
enum RegisterStatus {
  /// Nothing has happened yet (initial screen).
  initial,

  /// A request is in flight (show a loading indicator).
  loading,

  /// Registration succeeded and a [UserModel] is available.
  success,

  /// Something went wrong; see [RegisterState.errorMessage].
  error,
}

/// Immutable state for the register feature.
///
/// Field text values live in the form's [TextEditingController]s (and are
/// passed into [RegisterCubit.submit] at submit time), so they are
/// intentionally absent from this state — it only carries flow status plus
/// the result.
///
/// The [RegisterStatus] enum lives in this same file (per project convention)
/// so a single import gives access to both. The class is a plain concrete
/// class with a [copyWith] — no extra package required.
class RegisterState {
  const RegisterState({
    this.role = UserRole.student,
    this.status = RegisterStatus.initial,
    this.user,
    this.errorMessage,
  });

  /// Selected role (student / teacher).
  final UserRole role;

  /// Current status of the flow.
  final RegisterStatus status;

  /// The registered user (only set on [RegisterStatus.success]).
  final UserModel? user;

  /// Error message (only set on [RegisterStatus.error]).
  final String? errorMessage;

  /// Convenience flags derived from [status].
  bool get isLoading => status == RegisterStatus.loading;
  bool get isSuccess => status == RegisterStatus.success;
  bool get isError => status == RegisterStatus.error;

  /// Returns a copy of this state with the given fields replaced.
  RegisterState copyWith({
    UserRole? role,
    RegisterStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return RegisterState(
      role: role ?? this.role,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
