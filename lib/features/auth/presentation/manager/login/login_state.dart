import 'package:education_project_example/features/auth/data/models/user_model.dart';
import 'package:education_project_example/features/auth/data/models/user_role.dart';

/// All possible states the login flow can be in.
enum LoginStatus {
  /// Nothing has happened yet (initial screen).
  initial,

  /// A request is in flight (show a loading indicator).
  loading,

  /// Login succeeded and a [UserModel] is available.
  success,

  /// Something went wrong; see [LoginState.errorMessage].
  error,
}

/// Immutable state for the login feature.
///
/// Field text values live in the form's [TextEditingController]s (and are
/// passed into [LoginCubit.submit] at submit time), so they are intentionally
/// absent from this state — it only carries flow status plus the result.
///
/// The [LoginStatus] enum lives in this same file (per project convention)
/// so a single import gives access to both. The class is a plain concrete
/// class with a [copyWith] — no extra package required.
class LoginState {
  const LoginState({
    this.role = UserRole.student,
    this.status = LoginStatus.initial,
    this.user,
    this.errorMessage,
  });

  /// Selected role (student / teacher).
  final UserRole role;

  /// Current status of the flow.
  final LoginStatus status;

  /// The authenticated user (only set on [LoginStatus.success]).
  final UserModel? user;

  /// Error message (only set on [LoginStatus.error]).
  final String? errorMessage;

  /// Convenience flags derived from [status].
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isError => status == LoginStatus.error;

  /// Returns a copy of this state with the given fields replaced.
  LoginState copyWith({
    UserRole? role,
    LoginStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return LoginState(
      role: role ?? this.role,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
