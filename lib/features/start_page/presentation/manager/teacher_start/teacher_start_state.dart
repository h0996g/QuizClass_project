class TeacherStartState {
  const TeacherStartState({this.currentIndex = 0});

  final int currentIndex;

  TeacherStartState copyWith({int? currentIndex}) {
    return TeacherStartState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  String toString() => 'TeacherStartState(currentIndex: $currentIndex)';
}
