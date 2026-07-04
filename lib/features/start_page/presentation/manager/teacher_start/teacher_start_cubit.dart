import 'package:flutter_bloc/flutter_bloc.dart';

import 'teacher_start_state.dart';

class TeacherStartCubit extends Cubit<TeacherStartState> {
  TeacherStartCubit() : super(const TeacherStartState());

  void changeIndex(int index) => emit(state.copyWith(currentIndex: index));
}
