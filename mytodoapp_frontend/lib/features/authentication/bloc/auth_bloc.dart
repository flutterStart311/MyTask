import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mytodoapp_frontend/models/user_model.dart';
import 'package:mytodoapp_frontend/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices = AuthServices();

  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(signUpEvent);
    on<SignInEvent>(signInEvent);
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignUpInProgressState());
      await authServices.signUpUser(event.userModel);
      emit(SignUpSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignUpErrorState(error: 'Email already in use'));
      } else if (e.code == 'invalid-email') {
        emit(SignUpErrorState(error: 'Invalid Email'));
      } else if (e.code == 'operation-not-allowed') {
        emit(SignUpErrorState(error: 'Operation not allowed'));
      } else if (e.code == 'weak-password') {
        emit(SignUpErrorState(error: 'Weak Password'));
      }
    }
  }

  FutureOr<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SignInProgressState());
      await authServices.signInUser(event.email, event.password);
      emit(SignInSuccessState());
    } catch (e) {
      emit(SignInErrorState(error: e.toString()));
    }
  }
}
