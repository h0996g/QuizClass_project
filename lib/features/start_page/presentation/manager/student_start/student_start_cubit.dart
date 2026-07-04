import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_start_state.dart';

class StudentStartCubit extends Cubit<StudentStartState> {
  StudentStartCubit() : super(const StudentStartState());

  void changeIndex(int index) => emit(state.copyWith(currentIndex: index));
}
