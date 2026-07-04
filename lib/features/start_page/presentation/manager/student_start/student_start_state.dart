class StudentStartState {
  const StudentStartState({this.currentIndex = 0});

  final int currentIndex;

  StudentStartState copyWith({int? currentIndex}) {
    return StudentStartState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  String toString() => 'StudentStartState(currentIndex: $currentIndex)';
}
