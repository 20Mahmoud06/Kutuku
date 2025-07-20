import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/core/services/firebase_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError("Sign up failed. Please try again."));
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      emit(AuthError(message));
    } catch (e) {
      emit(AuthError("An unexpected error occurred: $e"));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError("Login failed. Please try again."));
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please check your credentials.';
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Invalid email or password.';
      }
      emit(AuthError(message));
    } catch (e) {
      emit(AuthError("An unexpected error occurred: $e"));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError("Google Sign-In was cancelled or failed."));
      }
    } catch (e) {
      emit(AuthError("An unexpected error occurred during Google sign-in: $e"));
    }
  }
}