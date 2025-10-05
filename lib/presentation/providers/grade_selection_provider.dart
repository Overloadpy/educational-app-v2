import 'package:flutter_riverpod/flutter_riverpod.dart';

class GradeSelectionState {
  final String? selectedGrade;
  final String? selectedStream;

  GradeSelectionState({
    this.selectedGrade,
    this.selectedStream,
  });

  GradeSelectionState copyWith({
    String? selectedGrade,
    String? selectedStream,
  }) {
    return GradeSelectionState(
      selectedGrade: selectedGrade ?? this.selectedGrade,
      selectedStream: selectedStream ?? this.selectedStream,
    );
  }

  bool get isGradeSelected => selectedGrade != null;
  bool get isStreamSelectionVisible =>
      selectedGrade == 'Grade 11' || selectedGrade == 'Grade 12';
  bool get canContinue =>
      isGradeSelected &&
      (!isStreamSelectionVisible || selectedStream != null);
}

class GradeSelectionNotifier extends StateNotifier<GradeSelectionState> {
  GradeSelectionNotifier() : super(GradeSelectionState());

  void selectGrade(String grade) {
    state = state.copyWith(
      selectedGrade: grade,
      selectedStream: null, // Reset stream when grade changes
    );
  }

  void selectStream(String stream) {
    state = state.copyWith(selectedStream: stream);
  }
}