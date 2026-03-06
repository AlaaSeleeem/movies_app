import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_event.dart';
import '../../domian/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthActionEventRegister>(_onAuthEventRegisterEvent);
    on<PasswordResetRequested>(_onPasswordResetRequested);
  }

  FutureOr<void> _onAuthEventRegisterEvent(
      AuthActionEventRegister event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await repository.register(request: event.request);
      emit(AuthSuccess("succeeded"));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "firebase error"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> _onPasswordResetRequested(
      PasswordResetRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await repository.sendPasswordResetEmail(email: event.email);
      emit(AuthSuccess('Password reset link sent! Check your email.'));
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }
}