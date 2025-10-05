import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/models/user_model.dart';
import '../../providers/grade_selection_provider.dart';

final gradeSelectionProvider =
    StateNotifierProvider<GradeSelectionNotifier, GradeSelectionState>(
  (ref) => GradeSelectionNotifier(),
);

class GradeSelectionScreen extends ConsumerWidget {
  const GradeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gradeSelectionProvider);
    final notifier = ref.read(gradeSelectionProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell Us About Yourself'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Grade',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildGradeOption(
              notifier,
              'Grade 9',
              state.selectedGrade,
            ),
            _buildGradeOption(
              notifier,
              'Grade 10',
              state.selectedGrade,
            ),
            _buildGradeOption(
              notifier,
              'Grade 11',
              state.selectedGrade,
            ),
            _buildGradeOption(
              notifier,
              'Grade 12',
              state.selectedGrade,
            ),
            const SizedBox(height: 32),
            if (state.isStreamSelectionVisible) ...[
              const Text(
                'Select Your Stream',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildStreamOption(
                notifier,
                'Natural Science',
                state.selectedStream,
              ),
              _buildStreamOption(
                notifier,
                'Social Science',
                state.selectedStream,
              ),
              const SizedBox(height: 32),
            ],
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: state.canContinue
                    ? () => _handleContinue(context, ref)
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeOption(GradeSelectionNotifier notifier, String grade, String? selectedGrade) {
    return Card(
      child: RadioListTile<String>(
        title: Text(grade),
        value: grade,
        groupValue: selectedGrade,
        onChanged: (value) => notifier.selectGrade(value!),
      ),
    );
  }

  Widget _buildStreamOption(GradeSelectionNotifier notifier, String stream, String? selectedStream) {
    return Card(
      child: RadioListTile<String>(
        title: Text(stream),
        value: stream,
        groupValue: selectedStream,
        onChanged: (value) => notifier.selectStream(value!),
      ),
    );
  }

  Future<void> _handleContinue(BuildContext context, WidgetRef ref) async {
    // Get the user box
    final userBox = await Hive.openBox<UserModel>('userBox');
    
    // Get the current user
    final currentUser = userBox.get('currentUser');
    
    if (currentUser != null) {
      // Get the selected grade and stream from the provider
      final gradeState = ref.read(gradeSelectionProvider);
      
      // Update the user's grade and stream
      currentUser.grade = gradeState.selectedGrade ?? '';
      currentUser.stream = gradeState.selectedStream;
      
      // Save the updated user
      await userBox.put('currentUser', currentUser);
      
      // Navigate to permissions screen
      if (context.mounted) {
        context.go('/permissions');
      }
    }
  }
}