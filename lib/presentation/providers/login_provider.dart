import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;

  LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  bool get isFormValid {
    return emailError == null &&
        passwordError == null &&
        email.isNotEmpty &&
        password.isNotEmpty;
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: email.isEmpty ? 'Email is required' : null,
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: password.isEmpty ? 'Password is required' : null,
    );
  }
  
  void setSubmitting(bool isSubmitting) {
    state = state.copyWith(isSubmitting: isSubmitting);
  }
}