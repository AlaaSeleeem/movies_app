import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'; // <--
import '../../data/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<PasswordResetRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        //..............
        await authRepo.sendPasswordResetEmail(email: event.email);
        // .............
        emit(AuthSuccess(message: 'Password reset link sent! Check your email.'));
      } on FirebaseAuthException catch (e) {
        // .............
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
    });
  }
}