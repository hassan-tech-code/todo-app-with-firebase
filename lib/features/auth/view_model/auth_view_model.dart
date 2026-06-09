import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_class/features/auth/data/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  String statusText = '';
  Color statusTextColor = Colors.transparent;
  AuthViewModel(this.authRepository);
  bool loading = false;
  String? error;

  void isLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading(true);

      await authRepository.signIn(email, password);
    } catch (e) {
      // isLoading = false;
      error = e.toString();

      notifyListeners();
    } finally {
      isLoading(false);
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      isLoading(true);

      await authRepository.signUp(email, password, name);
    } catch (e) {
      error = e.toString();
      notifyListeners();
    } finally {
      isLoading(false);
    }
  }

  Future<void> forogotPassword(String email) async {
    statusText = '';
    try {
      isLoading(true);

      await authRepository.forgotPassword(email);
      statusText = 'Password reset email sent';
      statusTextColor = Colors.green;
    } on FirebaseAuthException catch (e) {
      statusText = e.code.toString();
      statusTextColor = Colors.red;

      notifyListeners();
    } finally {
      isLoading(false);
    }
  }
}
