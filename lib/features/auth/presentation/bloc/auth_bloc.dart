import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/bloc/auth_event.dart';
import '../../domian/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.request.email,
        password: event.request.password,
      );
      String uid = userCredential.user!.uid;
      await _firestore.collection('users').doc(uid).set({
        'name': event.request.name,
        'email': event.request.email,
        'password': event.request.password,
        'phone': event.request.phone,
        'avatar': event.request.avaterId,
      });

      //
      event.request;
      emit(AuthSuccess("successed"));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "firebase error"));
    } catch (e) {
      emit(AuthError(e.toString() ?? "error"));
    }
  }
}
