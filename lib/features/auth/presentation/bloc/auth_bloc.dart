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
  }

  FutureOr<void> _onAuthEventRegisterEvent(
      AuthActionEventRegister event,
      Emitter<AuthState> emit
      ) async{
    emit(AuthLoading());

    try {
      await repository.register(request: event.request);
      emit(AuthSuccess("successed"));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "firebase error"));
    } catch (e) {
      emit(AuthError(e.toString() ?? "error"));
    }
  }
}
