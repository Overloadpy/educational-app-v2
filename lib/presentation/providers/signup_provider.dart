import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpState {
  bool get isFormValid {
    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }
  final String email;
  final String password;
  final String confirmPassword;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isSubmitting;

  SignUpState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isSubmitting = false,
  });

  SignUpState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? isSubmitting,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(SignUpState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: _validateEmail(email),
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: _validatePassword(password),
      confirmPasswordError: password != state.confirmPassword && state.confirmPassword.isNotEmpty
          ? 'Passwords do not match'
          : state.confirmPasswordError,
    );
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: _validateConfirmPassword(state.password, confirmPassword),
    );
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }
    // Simple email validation regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

}