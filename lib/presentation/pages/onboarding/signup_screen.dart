import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/signup_provider.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(),
);

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpProvider);
    final notifier = ref.read(signUpProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: state.emailError,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: notifier.updateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: state.passwordError,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: notifier.updatePassword,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: state.confirmPasswordError,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: notifier.updateConfirmPassword,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.isFormValid && !state.isSubmitting
                  ? () => _handleSignUp(context, ref)
                  : null,
              child: state.isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignUp(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(signUpProvider.notifier);
    
    // Set submitting state
    notifier.state = notifier.state.copyWith(isSubmitting: true);
    
    // Simulate network call
    await Future.delayed(const Duration(seconds: 1));
    
    if (context.mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign Up Successful! (Demo Mode)'),
        ),
      );
      
      // Navigate to grade selection
      context.go('/grade-stream');
    }
  }
}