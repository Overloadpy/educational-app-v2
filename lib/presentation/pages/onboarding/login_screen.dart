import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/login_provider.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Back'),
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.isFormValid && !state.isSubmitting
                  ? () => _handleLogin(context, ref)
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
                  : const Text('Login'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/signup'),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(loginProvider.notifier);
    
    // Set submitting state
    notifier.setSubmitting(true);
    
    // Simulate network call
    await Future.delayed(const Duration(seconds: 1));
    
    if (context.mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful! (Demo Mode)'),
        ),
      );
      
      // Navigate to home
      context.go('/home');
    }
  }
}